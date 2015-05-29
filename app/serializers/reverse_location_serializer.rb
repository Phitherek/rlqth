class ReverseLocationSerializer < ActiveModel::Serializer
  attributes :id, :locator, :latitude, :longitude, :reverse_address
end
