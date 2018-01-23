class Api::V1::RentalsController < Api::V1::BaseController

  expose :rentals, ->{ Rental.all }
  expose :rental

  def create
    rental.save
  end

  def update
    rental.update(rental_params)
  end

  def destroy
    rental.destroy
  end

  private

  def rental_params
    params.require(:rental).permit(:name, :daily_rate)
  end
end
