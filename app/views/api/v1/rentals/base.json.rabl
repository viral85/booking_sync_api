attributes :id, :name, :daily_rate
node(:bookings) do |rental|
  rental.bookings.ids
end
