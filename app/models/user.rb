class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :assets
  has_many :liabilities
  has_many :categories
  before_create :add_jti

  def add_jti
    self.jti ||= SecureRandom.uuid
  end
end
