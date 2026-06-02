class CreateOrganizations < ActiveRecord::Migration[8.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :fineract_tenant_id, null: false
      t.string :fineract_base_url, null: false
      t.string :fineract_service_auth
      t.string :timezone, default: "UTC"
      t.string :currency, limit: 3
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :organizations, :slug, unique: true
    add_index :organizations, :fineract_tenant_id, unique: true
  end
end
