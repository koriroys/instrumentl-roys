class RecipientSerializer
  include JSONAPI::Serializer
  attributes :id, :ein, :name
  has_many :addresses
end
