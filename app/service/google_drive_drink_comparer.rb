class GoogleDriveDrinkComparer

  # Connect
  # Open up a particular excel spreadsheet
  # Compare it with the last saved version to see if there is anything new
  # If there is something new we want to save it to our database
  # Save a copy of the lastest version of the sheet for tomorrow's comparisson.
  # Disconnect from Gdrive if possible/needed

  def initialize
    session = GoogleDrive.login(ENV["GOOGLE_USERNAME"], ENV["GOOGLE_PASSWORD"])
    @ws = session.spreadsheet_by_key(ENV["SPREADSHEET_KEY"]).worksheets[0]
  end

  def save_drinks_from_spreadsheet
    for column in Drink::COLUMN_HEADERS.keys.map(&:to_i)
      for row in 2..@ws.num_rows
        create_drink(row, column)
      end
    end
  end

  def create_drink(row, column)
    column_header = Drink::COLUMN_HEADERS[column.to_s]
    name = @ws[row, column]
    if (not name.blank? and not is_duplicate?(row, column_header))
      grade = get_drink_grade(row, column, column_header)

      drink = Drink.new(name: name, grade: grade,
        row_position: row, drink_type: column_header)
      drink.ingredient = @ws[row, column + 1] if column_header == "cocktail"
      drink.save
    end
  end

  def is_duplicate?(row, drink_type)
    Drink.where(row_position: row, drink_type: drink_type).present?
  end

  def get_drink_grade(row, column, drink_type)
    if drink_type == "cocktail"
      @ws[row, column + 2]
    else
      @ws[row, column + 1]
    end
  end
end
