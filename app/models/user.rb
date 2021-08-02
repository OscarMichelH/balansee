class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

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
      case liability.frequency
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

    divide_by_frecuency(frequency, yearly_balance)
  end

  def income_calculated(frequency, is_salary, is_business, is_stock)
    yearly_balance = 0.0
    assets.where(is_salary: is_salary, is_business: is_business, is_stock: is_stock).each do |asset|
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

    divide_by_frecuency(frequency, yearly_balance)
  end

  def avg_balances
    yearly_balance = balance_calculated('YEARLY')
    color = yearly_balance > 0 ? 'text-success' : 'text-danger'
    result = ''
    result += '<p class= "' + color+ '"><strong>YEARLY: </strong>' + (yearly_balance).truncate(0).to_s + '</p>'
    result += '<p class= "' + color+ '"><strong>MONTHLY: </strong>' + (yearly_balance/12).truncate(0).to_s + '</p>'
    result += '<p class= "' + color+ '"><strong>WEEKLY: </strong>' + (yearly_balance/52.1429).truncate(0).to_s + '</p>'
    result += '<p class= "' + color+ '"><strong>DAILY: </strong>' + (yearly_balance/365).truncate(0).to_s + '</p>'
    return result
  end

  private

  def divide_by_frecuency(frequency, yearly_balance)
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
end
