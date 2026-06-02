class DeviseCreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string :role, null: false, default: "loan_officer"
      t.integer :fineract_staff_id
      t.integer :fineract_appuser_id
      t.string :fineract_username
      t.boolean :active, default: true

      t.timestamps null: false
    end

    add_index :users, :email
    add_index :users, :reset_password_token, unique: true
    add_index :users, [:email, :organization_id], unique: true
  end
end
