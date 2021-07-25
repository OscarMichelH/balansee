class AddFrequencyToLiabilities < ActiveRecord::Migration[6.1]
  def change
    add_column :liabilities, :frequency, :string
  end
end
