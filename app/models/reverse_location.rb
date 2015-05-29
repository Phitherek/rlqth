class ReverseLocation < ActiveRecord::Base
    validates :locator, presence: true, uniqueness: true
    validates :latitude, presence: true
    validates :longitude, presence: true

    reverse_geocoded_by :latitude, :longitude, address: :reverse_address, lookup: :nominatim

    before_validation :latlon_from_locator
    after_validation :reverse_geocode

    private

    def latlon_from_locator
        latlon = Rlqth::Utils.dimensions_from_locator(self.locator)
        self.latitude = latlon[0]
        self.longitude = latlon[1]
    end
end
