class Drink < ActiveRecord::Base

	validates :drink_type, presence: true
	validates :name, presence: true
	validates :row_position, presence: true

  COLUMN_HEADERS = { "1" => "wine",
                     "3" => "other",
                     "5" => "beer",
                     "7" => "cocktail",
                     "10" => "whiskey" }

    scope :rated, where("grade is not NULL") 
    scope :unrated, where(grade: nil)
end

