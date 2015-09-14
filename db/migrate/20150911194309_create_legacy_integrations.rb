class CreateLegacyIntegrations < ActiveRecord::Migration
  def change
    create_table :legacy_integrations, id: :uuid do |t|
      t.string :username
      t.string :code
      t.string :branches, array: true, default: []
      t.uuid :membership_id
      t.timestamps null: false
    end
    add_index :legacy_integrations, :membership_id
    add_index :legacy_integrations, :branches, using: 'gin'
  end
end
