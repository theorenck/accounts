class Application < ActiveRecord::Base
  before_create :set_secret

  has_and_belongs_to_many :organizations,  :join_table => :subscriptions
  has_many :authorizations

  validates :name, :version, :redirect_uri, presence: true
  validates :redirect_uri, uniqueness: true

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :secret,
        :name,
        :description,
        :version,
        :redirect_uri,
        :scopes,
        :created_at,
        :updated_at
      ]
    }.merge(options))
  end

  private
    def set_secret
      return if secret.present?
      self.secret = generate_secret
    end

    def generate_secret
      loop do
        secret = SecureRandom.hex
        break secret unless self.class.exists?(secret: secret)
      end
    end

end
