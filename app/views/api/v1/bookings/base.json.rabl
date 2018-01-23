attributes :id, :start_at, :end_at, :price, :client_email
child(:rental) do
  extends 'api/v1/rentals/base'
end
