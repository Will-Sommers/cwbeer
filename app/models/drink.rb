class Drink < ActiveRecord::Base

	validates :type, presence: true
	validates :name, presence: true
	validates :row_position, presence: true


end

