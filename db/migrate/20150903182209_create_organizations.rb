class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations, id: :uuid  do |t|
      t.string :name
      t.uuid :owner_id, index: true
     	t.timestamps null: false
    end
  end
end
