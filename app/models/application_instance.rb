class ApplicationInstance < ActiveRecord::Base
  belongs_to :application
  has_and_belongs_to_many :organizations,  :join_table => :subscriptions
end
