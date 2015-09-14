class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations, id: :uuid  do |t|
      t.uuid :application_instance_id
      t.uuid :membership_id
      t.timestamps null: false
    end
    add_index :authorizations, [:application_instance_id, :membership_id],
      unique: true, name: 'index_authorizations_on_application_and_membership'
  end
end
