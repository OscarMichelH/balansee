class IncomeStatementController < ApplicationController
  before_action :authenticate_user!

  def index
    @assets = current_user.assets
    @liabilities  = current_user.liabilities
  end
end
