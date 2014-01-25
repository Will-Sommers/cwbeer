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

  def print_column_five
    for row in 1..@ws.num_rows
      puts @ws[row, 5]
    end
  end

  def test
    save_drink(397, 5)
  end

  def save_drink(row, column)
    grade = @ws[row, column + 1]
    drink = Drink.new(name: @ws[row, column], grade: grade, row_position: row)
    drink.drink_type = Drink::COLUMN_HEADERS[column.to_s]
    drink.save
  end

end
