class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :phone_number
      t.string :image, default: 'https://cdn-icons-png.flaticon.com/128/3171/3171065.png'
      t.string :full_name
      t.string :role, default: 'customer'
      t.string :provider, default: 'system'
      t.string :uid, default: 'system'
      t.boolean :status, default: false
      t.string :password_digest

      t.timestamps
    end
  end
end
