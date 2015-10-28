class CreateMemberships < ActiveRecord::Migration
  def change

    create_table :memberships, id: :uuid  do |t|
      t.uuid :organization_id
      t.uuid :user_id
      t.boolean :active, default: false
      t.timestamps null: false
      t.jsonb :integration, null: false, default: '{}'
    end

    add_index :memberships, [:organization_id, :user_id], unique: true
    add_index :memberships, :integration, using: :gin
  end
end
