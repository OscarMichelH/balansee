class AddFrequencyToAssets < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :frequency, :string
  end
end
