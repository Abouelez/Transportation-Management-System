class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :role, default: 1  # 0 for admin , 1 for driver

      t.timestamps
    end
  end
end
