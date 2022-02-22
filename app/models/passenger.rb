class Passenger < ApplicationRecord
  belongs_to :booking

  validates_uniqueness_of :name, scope: :email
end
