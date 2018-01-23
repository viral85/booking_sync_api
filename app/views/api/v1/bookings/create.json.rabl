object booking
if booking.persisted?
  extends 'api/v1/bookings/base'
else
  attributes :errors
end
