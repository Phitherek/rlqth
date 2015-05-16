class PureLocationSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :locator
end
