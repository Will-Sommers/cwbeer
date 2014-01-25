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
    save_wine
  end

  def save_wine
    for row in 2..@ws.num_rows
      save_drink(row, 1)
    end
  end

  def test
    save_drink(397, 5)
  end

  def save_drink(row, column)
    column_name = Drink::COLUMN_HEADERS[column.to_s]

    name = @ws[row, column]
    unless name.blank?
      unless is_duplicate?(row, column_name)
        grade = @ws[row, column + 1]
        drink = Drink.new(name: name, grade: grade,
          row_position: row, drink_type: column_name)
        drink.save
      end
    end
  end

  def is_duplicate?(row, drink_type)
    Drink.where(row_position: row, drink_type: drink_type).present?
  end

end
