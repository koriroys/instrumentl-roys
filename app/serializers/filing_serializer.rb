class FilingSerializer
  include JSONAPI::Serializer
  attributes :id
  belongs_to :filer, serializer: :organization, id_method_name: :organization_id
  has_many :awards
end
