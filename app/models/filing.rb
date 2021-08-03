class Filing < ApplicationRecord
  belongs_to :filer, foreign_key: :organization_id, class_name: "Organization"
  has_many :awards
end
