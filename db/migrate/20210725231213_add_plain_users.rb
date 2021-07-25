class AddPlainUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :plain_users do |t|
      t.string :email
      t.string :password
      t.string :confirmation_password

      t.timestamps
    end
  end
end
