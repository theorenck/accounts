class ServiceInstance < ActiveRecord::Base
  belongs_to :service
  belongs_to :organization

  validates :url, :service, :organization, presence: true
end
