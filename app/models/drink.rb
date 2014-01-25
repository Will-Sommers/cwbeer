class Drink < ActiveRecord::Base

	validates :type, presence: true
	validates :name, presence: true
	validates :row_position, presence: true

  COLUMN_HEADERS = { "1" => "wine", "3" => "other", "5" => "beer", "7" => "coctail", "10" => "whiskey" }


end

