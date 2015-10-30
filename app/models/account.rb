class Account < ActiveRecord::Base

  belongs_to :user
  belongs_to :organization
  belongs_to :application
  belongs_to :authorization

end
