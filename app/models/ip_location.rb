class IpLocation < ActiveRecord::Base
    validates :ip, presence: true, uniqueness: true

    geocoded_by :ip, lookup: :freegeoip
    after_validation :geocode
end
