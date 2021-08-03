class AwardSerializer
  include JSONAPI::Serializer

  attributes :id, :amount, :purpose
end
