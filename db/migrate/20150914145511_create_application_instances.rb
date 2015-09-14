class CreateApplicationInstances < ActiveRecord::Migration
  def change
    create_table :application_instances, id: :uuid  do |t|
      t.string :version
      t.string :code
      t.string :name
      t.string :description
      t.string :url, unique: true

      t.timestamps null: false
    end
  end
end
