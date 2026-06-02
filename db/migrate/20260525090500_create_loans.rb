class CreateLoans < ActiveRecord::Migration[8.1]
  def change
    create_table :loans do |t|
      t.references :organization,     null: false, foreign_key: true
      t.references :borrower,         null: false, foreign_key: true
      t.references :loan_product,     null: false, foreign_key: true
      t.references :loan_application, foreign_key: true
      t.references :assigned_officer, foreign_key: { to_table: :users }
      t.integer :fineract_loan_id,   null: false
      t.string  :fineract_account_no
      t.string  :status              # mirrored from Fineract, updated on fetch
      t.decimal :principal_amount,   precision: 15, scale: 4
      t.timestamps
    end

    add_index :loans, [:organization_id, :fineract_loan_id], unique: true
  end
end
