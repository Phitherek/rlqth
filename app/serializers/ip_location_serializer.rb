class IpLocationSerializer < ActiveModel::Serializer
  attributes :id, :ip, :latitude, :longitude, :locator
end
