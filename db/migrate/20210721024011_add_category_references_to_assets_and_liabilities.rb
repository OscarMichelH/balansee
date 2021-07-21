class AddCategoryReferencesToAssetsAndLiabilities < ActiveRecord::Migration[6.1]
  def change
    add_reference :assets, :category, null: true , foreign_key: true
    add_reference :liabilities, :category, null: true , foreign_key: true
  end
end
