class User < Ohm::Model
  attribute :username
  
  # unique :username
  index :username

  def self.create_with_omniauth(auth)
    create(username: auth['info']['nickname'])
  end
end
