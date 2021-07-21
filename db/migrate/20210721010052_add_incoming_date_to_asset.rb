class AddIncomingDateToAsset < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :incoming_date, :date
  end
end
