class Organization < ActiveRecord::Base

	has_many :memberships
  has_many :users, through: :memberships
  has_many :profiles, as: :profileable
  has_one :owner, foreign_key: 'id', class_name: 'User', primary_key: 'owner_id'

  def as_json(options={})
    {
      id: id,
      name: name,
      members: users,
      owner: owner,
      created_at: created_at,
      updated_at: updated_at
    }
  end

end
