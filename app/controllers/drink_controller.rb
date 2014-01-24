class DrinkController < ApplicationController

def create
	@drink = Drink.new
	@drink.type = "henry"
	@drink.name = "henry"
	@drink.row_position = "henry"
	@drink.grade = "henry"
	@drink.save
end

end
