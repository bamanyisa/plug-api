class CreateLoanApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :loan_applications do |t|
      t.references :organization,     null: false, foreign_key: true
      t.references :borrower,         null: false, foreign_key: true
      t.references :assigned_officer, foreign_key: { to_table: :users }
      t.integer :fineract_product_id, null: false  # Fineract loan product — no local FK
      t.integer :fineract_loan_id                  # set when submitted to Fineract
      t.string  :status,           null: false, default: "draft"  # draft | submitted | rejected
      t.decimal :requested_amount, precision: 15, scale: 4, null: false
      t.integer :requested_term
      t.text    :purpose
      t.text    :rejection_reason
      t.timestamps
    end

    add_index :loan_applications, [:organization_id, :status]
    add_index :loan_applications, [:organization_id, :fineract_loan_id], unique: true, where: "fineract_loan_id IS NOT NULL"
  end
end
