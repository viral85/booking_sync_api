class Api::V1::BookingsController < Api::V1::BaseController

  expose :bookings, ->{ Booking.all }
  expose :booking

  def create
    booking.save
  end

  def update
    booking.update(booking_params)
  end

  def destroy
    booking.destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:rental_id, :start_at, :end_at, :client_email, :price)
  end

end
