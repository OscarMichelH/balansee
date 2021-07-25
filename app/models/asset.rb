class Asset < ApplicationRecord
  validates_presence_of :income
  belongs_to :user
  belongs_to :category, optional: true
end
