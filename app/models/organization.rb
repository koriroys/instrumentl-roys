class Organization < ApplicationRecord
  has_many :awards
  has_many :organization_addresses
  has_many :addresses, through: :organization_addresses
end
