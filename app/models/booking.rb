class Booking < ApplicationRecord
  belongs_to :rental

  validates :start_at, :end_at, :client_email, :price , presence: { message: "Required" }
  validates :price, numericality: { greater_than_or_equal_to: 0, :message => "Must be greater than or equal to 0" }

   validate :start_at_cannot_be_in_the_past
   validate :end_at_must_be_after_start_at
   validate :email_format
   validate :booking_overlapping
   validate :price_check


   scope :overlapped, ->(rental,opts) {
     query = where(rental_id: rental.id)

     if(opts[:start_at].present?)
       query = overlapped_query(query,'end_at', '>', opts[:start_at])

     end
     if(opts[:end_at].present?)
       query = overlapped_query(query,'start_at', '<', opts[:end_at])
     end
     query
   }

   private

   def booking_overlapping
     p Booking.overlapped(rental, {start_at: start_at, end_at: end_at})
     if Booking.overlapped(rental, {start_at: start_at, end_at: end_at}).where.not(id: id).present?
       errors.add(:start_at, "Not avilable for this dates")
     end
   end

   def self.overlapped_query(query, field, operator, time)
     query.where("#{field}::timestamp #{operator} ?::timestamp", time.to_s)
   end

   def email_format
     unless client_email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors.add(:client_email, "is not an email")
    end
   end

   def start_at_cannot_be_in_the_past
     if start_at.present? && start_at < Date.today
       errors.add(:start_at, "Must be greater than Today")
     end
   end

   def end_at_must_be_after_start_at
     if end_at.present? && start_at.present? &&  end_at <= start_at
       errors.add(:end_at, "Must be greater than Start At")
     end
   end

   def price_check
     if price.present? && price != actual_price
       errors.add(:price, "Check Price Calculation")
     end
   end

   def number_of_days
     if end_at.present? && start_at.present?
      (end_at - start_at).to_i
     end
   end

   def actual_price
     if number_of_days.present?
       number_of_days * rental.daily_rate
     end
   end

end
