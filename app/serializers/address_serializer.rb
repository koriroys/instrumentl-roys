class AddressSerializer
  include JSONAPI::Serializer

  attributes :id, :city, :state, :zip, :line_1
end
