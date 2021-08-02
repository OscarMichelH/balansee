class AddIsStockToAssets < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :is_salary, :boolean, default: false
    add_column :assets, :is_stock, :boolean, default: false
    add_column :assets, :is_business, :boolean, default: false
  end
end
