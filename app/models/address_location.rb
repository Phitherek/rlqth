class AddressLocation < ActiveRecord::Base
    validates :address, presence: true, uniqueness: true

    geocoded_by :address, lookup: :nominatim
    after_validation :geocode
end
