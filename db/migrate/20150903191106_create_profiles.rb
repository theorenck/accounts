class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :description
      t.references :profileable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
