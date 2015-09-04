class CreateServices < ActiveRecord::Migration
  def change
    create_table :services, id: :uuid  do |t|
      t.uuid :type_id, index: true
      t.uuid :organization_id, index: true
      t.string :name
      t.string :description
      t.string :url

      t.timestamps null: false
    end
  end
end
