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

  def balance_calculated(frequency)
    yearly_balance = 0.0
    assets.each do |asset|
      case asset.frequency
      when 'YEARLY'
        yearly_balance += asset.income
      when 'MONTHLY'
        yearly_balance += (asset.income * 12)
      when 'WEEKLY'
        yearly_balance += (asset.income * 52.1429)
      when 'DAILY'
        yearly_balance += (asset.income * 365)
      end
    end

    liabilities.each do |liability|
      case asset.frequency
      when 'YEARLY'
        yearly_balance += liability.payment
      when 'MONTHLY'
        yearly_balance += (liability.payment * 12)
      when 'WEEKLY'
        yearly_balance += (liability.payment * 52.1429)
      when 'DAILY'
        yearly_balance += (liability.payment * 365)
      end
    end

    case frequency
    when 'YEARLY'
      return yearly_balance
    when 'MONTHLY'
      return yearly_balance / 12
    when 'WEEKLY'
      return yearly_balance / 52.1429
    when 'DAILY'
      return yearly_balance / 365
    else
      return 0
    end
  end

  def avg_balances
    yearly_balance = balance_calculated('YEARLY')
    result = ''
    result += '<strong>YEARLY: </strong>' + (yearly_balance).truncate(0).to_s + '<br>'
    result += '<strong>MONTHLY: </strong>' + (yearly_balance/12).truncate(0).to_s + '<br>'
    result += '<strong>WEEKLY: </strong>' + (yearly_balance/52.1429).truncate(0).to_s + '<br>'
    result += '<strong>DAILY: </strong>' + (yearly_balance/365).truncate(0).to_s
    return result
  end
end
