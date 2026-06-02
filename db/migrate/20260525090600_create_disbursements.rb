class CreateDisbursements < ActiveRecord::Migration[8.1]
  def change
    create_table :disbursements do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :loan,         null: false, foreign_key: true
      t.references :disbursed_by, foreign_key: { to_table: :users }
      t.decimal :amount,      precision: 15, scale: 4, null: false
      t.date    :disbursed_on, null: false
      t.string  :payment_type
      t.integer :fineract_transaction_id  # set after Fineract confirms
      t.timestamps
    end
  end
end
