class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles, id: :uuid  do |t|
      t.string :description
      t.uuid :profileable_id
      t.string :profileable_type
      t.timestamps null: false
    end
    add_index :profiles, [:profileable_id, :profileable_type], unique: true
  end
end
