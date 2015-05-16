class AddressLocationSerializer < ActiveModel::Serializer
  attributes :id, :address, :latitude, :longitude, :locator
end