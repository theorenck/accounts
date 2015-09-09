class CreateServiceTypes < ActiveRecord::Migration
  def change
    create_table :service_types, id: :uuid  do |t|
      t.string :code
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
