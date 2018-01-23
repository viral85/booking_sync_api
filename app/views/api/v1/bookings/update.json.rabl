object booking
if booking.valid?
  extends 'api/v1/bookings/base'
else
  attributes :errors
end
