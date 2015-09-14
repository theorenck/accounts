class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations, id: :uuid  do |t|
      t.uuid :application_id
      t.uuid :membership_id
      t.string :scopes, array: true, default: []
      t.timestamps null: false
    end
    add_index :authorizations, [:application_id, :membership_id],
      unique: true, name: 'index_authorizations_on_application_and_membership'
  end
end
