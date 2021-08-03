class Award < ApplicationRecord
  belongs_to :recipient, class_name: "Organization"
  belongs_to :filing
end
