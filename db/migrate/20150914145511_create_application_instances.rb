class CreateApplicationInstances < ActiveRecord::Migration
  def change
    create_table :application_instances, id: :uuid  do |t|
      t.string :url, unique: true
      t.string :version
      t.uuid :application_id
      t.timestamps null: false
    end
  end
end
