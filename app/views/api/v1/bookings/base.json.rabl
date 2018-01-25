attributes :id, :start_at, :end_at, :price, :client_email
# child(:rental) do
#   extends 'api/v1/rentals/base'
# end
node(:rental) do |booking|
  booking.rental_id
end
node(:rental_daily_rate) do |booking|
  booking.rental.daily_rate
end

# node(:start_at) do |booking|
# 	booking.start_at.strftime('%d/%m/%Y')
# end

# node(:end_at) do |booking|
# 	booking.end_at.strftime('%d/%m/%Y')
# end