class Subscription < ActiveRecord::Base

  belongs_to :application
  belongs_to :organization

end
