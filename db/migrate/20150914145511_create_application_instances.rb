class CreateApplicationInstances < ActiveRecord::Migration
  def change
    create_table :application_instances, id: :uuid  do |t|
      t.string :url, unique: true
      t.string :version
      t.uuid :application_id
      t.timestamps null: false
    end

    create_table :app_instances_organizations, id: :uuid  do |t|
     t.uuid :application_instance, index: true
     t.uuid :organization, index: true
    end
  end
end
