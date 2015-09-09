class CreateServices < ActiveRecord::Migration
  def change
    create_table :services, id: :uuid  do |t|
      t.uuid :type_id, index: true
      t.string :version

      t.timestamps null: false
    end
  end
end
