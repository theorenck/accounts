class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.belongs_to :service_type, index: true
      t.belongs_to :organization, index: true
      t.string :name
      t.string :description
      t.string :url

      t.timestamps null: false
    end
  end
end
