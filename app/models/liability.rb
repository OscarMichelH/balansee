class Liability < ApplicationRecord
  validates_presence_of :payment
  belongs_to :user
  belongs_to :category

  before_save :validate_negative_payment

  def validate_negative_payment
    self.payment = self.payment * -1 if self.payment > 0
  end
end
