object rental
if rental.valid?
  extends 'api/v1/rentals/base'
else
  attributes :errors
end
