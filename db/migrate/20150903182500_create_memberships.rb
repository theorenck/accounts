class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships, id: :uuid  do |t|
      t.uuid :organization_id
      t.uuid :user_id
      t.timestamps null: false
    end
    add_index :memberships, [:organization_id, :user_id], unique: true
  end
end
