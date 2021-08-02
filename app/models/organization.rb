class Organization < ApplicationRecord
  has_many :awards
  has_many :addresses
end
