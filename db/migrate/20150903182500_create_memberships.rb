class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships, id: :uuid  do |t|
      t.belongs_to :organization, index: true
      t.belongs_to :user, index: true
      t.boolean :owner
      t.timestamps null: false
    end
  end
end
