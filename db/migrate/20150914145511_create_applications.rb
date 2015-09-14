class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications, id: :uuid  do |t|
      t.string :name
      t.string :version
      t.string :redirect_uri, unique: true
      t.string :description
      t.string :secret
      t.string :scopes, array: true, default: []

      t.timestamps null: false
    end
  end
end
