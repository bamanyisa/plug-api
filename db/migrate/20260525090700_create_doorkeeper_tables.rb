class CreateDoorkeeperTables < ActiveRecord::Migration[8.1]
  def change
    create_table :oauth_applications do |t|
      t.string :name, null: false
      t.string :uid, null: false
      t.string :secret, null: false
      t.text :redirect_uri, null: false
      t.string :scopes, default: "", null: false
      t.boolean :confidential, default: true, null: false
      t.timestamps null: false
    end

    add_index :oauth_applications, :uid, unique: true

    create_table :oauth_access_grants do |t|
      t.references :resource_owner, null: false, polymorphic: true
      t.references :application, null: false
      t.string :token, null: false
      t.integer :expires_in, null: false
      t.text :redirect_uri, null: false
      t.datetime :created_at, null: false
      t.datetime :revoked_at
      t.string :scopes, default: "", null: false
    end

    add_foreign_key :oauth_access_grants, :oauth_applications, column: :application_id
    add_index :oauth_access_grants, :token, unique: true

    create_table :oauth_access_tokens do |t|
      t.references :resource_owner, polymorphic: true
      t.references :application
      t.string :token, null: false
      t.string :refresh_token
      t.integer :expires_in
      t.datetime :revoked_at
      t.datetime :created_at, null: false
      t.string :scopes
      t.string :previous_refresh_token, default: "", null: false
    end

    add_foreign_key :oauth_access_tokens, :oauth_applications, column: :application_id
    add_index :oauth_access_tokens, :token, unique: true
    add_index :oauth_access_tokens, :refresh_token, unique: true

    create_table :oauth_access_token_requests do |t|
      t.references :user, polymorphic: true
      t.references :client
      t.string :token, null: false
      t.string :refresh_token
      t.integer :expires_in
      t.datetime :revoked_at
      t.datetime :created_at, null: false
      t.string :scopes
    end

    create_table :oauth_openid_requests do |t|
      t.references :access_grant, null: false
      t.string :nonce, null: false
      t.string :acr_values
      t.string :claims_locales
      t.string :ui_locales
      t.string :id_token_hint
      t.string :login_hint
      t.string :raw_claims
      t.timestamps
    end

    add_foreign_key :oauth_openid_requests, :oauth_access_grants, column: :access_grant_id

    create_table :oauth_access_token_requests_audiences do |t|
      t.string :audience, null: false
      t.references :oauth_access_token_request, null: false
      t.timestamps
    end
  end
end
