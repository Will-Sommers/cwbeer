class DrinksController < ApplicationController

	def index
		@drinks = Drink.all
	end


  def refresh
    GoogleDriveDrinkComparer.new.save_drinks_from_spreadsheet
    redirect_to action: "index"
  end
end
