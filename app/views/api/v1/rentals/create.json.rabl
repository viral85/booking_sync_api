object rental
if rental.persisted?
  extends 'api/v1/rentals/base'
else
  attributes :errors
end
