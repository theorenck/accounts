class CreateMemberships < ActiveRecord::Migration
  def change
    enable_extension "hstore"

    create_table :memberships, id: :uuid  do |t|
      t.uuid :organization_id
      t.uuid :user_id
      t.boolean :authorized, default: false
      t.timestamps null: false
      t.hstore :legacy_integrations
    end

    add_index :memberships, [:organization_id, :user_id], unique: true
    add_index  :memberships, :legacy_integrations, using: :gin
  end
end

