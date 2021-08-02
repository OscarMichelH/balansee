class IncomeStatementController < ApplicationController
  before_action :authenticate_user!

  def index
    frequency = params[:frequency] || 'DAILY'
    @salary_incomes = current_user.income_calculated(frequency, true, false, false)&.round(2)
    @business_incomes = current_user.income_calculated(frequency, false, true, false)&.round(2)
    @dividend_incomes = current_user.income_calculated(frequency, false, false, true)&.round(2)
    @total_incomes = (@salary_incomes + @business_incomes + @dividend_incomes)&.round(2)
    @liabilities  = current_user.liabilities
  end
end
