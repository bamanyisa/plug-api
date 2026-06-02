class CreateLoanProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :loan_products do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.string :short_name, null: false
      t.string :currency_code, null: false
      t.integer :currency_decimal_places, default: 2
      t.decimal :min_principal, precision: 15, scale: 4
      t.decimal :max_principal, precision: 15, scale: 4
      t.decimal :default_principal, precision: 15, scale: 4
      t.decimal :nominal_interest_rate, precision: 8, scale: 4
      t.string :amortization_type
      t.string :interest_type
      t.string :repayment_frequency
      t.integer :repayment_every
      t.integer :number_of_repayments
      t.integer :fineract_product_id
      t.string :sync_status, default: "pending"
      t.datetime :synced_at
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :loan_products, [:organization_id, :fineract_product_id], unique: true, where: "fineract_product_id IS NOT NULL"
  end
end
