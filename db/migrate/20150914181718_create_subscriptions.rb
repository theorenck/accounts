class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions, id: :uuid  do |t|
     t.uuid :application_instance_id
     t.uuid :organization_id
     t.timestamps null: false
    end
    add_index :subscriptions, [:application_instance_id, :organization_id], unique: true
  end
end
