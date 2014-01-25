class Drink < ActiveRecord::Base

	validates :type, presence true
	validates :name, presence true
	validates :row_position, presence true

def create
	@drink = Drink.new
	@drink.type = params[:drink]
	@drink.name = params[:drink]
	@drink.row_position = params[:drink]
	@drink.save
end

end

