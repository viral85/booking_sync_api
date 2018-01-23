class Rental < ApplicationRecord
  validates :name, :daily_rate,  presence: { message: "Required" }
  validates :name, uniqueness: { :case_sensitive => false, message: "Is Already Taken" }
  validates :daily_rate, numericality: { greater_than_or_equal_to: 0, :message => "Must be greater than or equal to 0" }

end
