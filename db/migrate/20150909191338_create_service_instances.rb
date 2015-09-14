class CreateServiceInstances < ActiveRecord::Migration
  def change
    create_table :service_instances, id: :uuid  do |t|
      t.string :uri, unique: true
      t.uuid :service_id
      t.uuid :organization_id

      t.timestamps null: false
    end
    add_index :service_instances, [:service_id, :organization_id], unique: true
  end
end
