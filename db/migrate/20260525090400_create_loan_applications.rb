class CreateLoanApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :loan_applications do |t|
      t.references :organization,     null: false, foreign_key: true
      t.references :borrower,         null: false, foreign_key: true
      t.references :loan_product,     null: false, foreign_key: true
      t.references :assigned_officer, foreign_key: { to_table: :users }
      t.references :approved_by,      foreign_key: { to_table: :users }
      t.string  :status,           null: false, default: "draft"
      t.decimal :requested_amount, precision: 15, scale: 4, null: false
      t.integer :requested_term
      t.text    :purpose
      t.text    :rejection_reason
      t.timestamps
    end

    add_index :loan_applications, [:organization_id, :status]
  end
end
