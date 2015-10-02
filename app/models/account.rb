class Account < ActiveRecord::Base
  # self.primary_key = "id"

  def as_json(options={})
    {
      id: id,
      name: name,
      version: version,
      redirect_uri: redirect_uri,
      scopes: scopes
    }
  end

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :name,
        :version,
        :redirect_uri,
        :scopes
      ]
    }.merge(options))
  end
  
end
