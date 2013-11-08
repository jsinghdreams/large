class User < ActiveRecord::Base
  
  has_many :posts
  has_many :owned_collections, 
  class_name: "Collection", 
  foreign_key: :owner_id
  
  has_many :collection_followers, foreign_key: :follower_id
  has_many :followed_collections, 
    through: :collection_followers,
    source: :collection

  has_many :collection_invitations
  has_many :invited_collections, 
    through: :collection_invitations,
    source: :collection

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_with_omniauth(auth)
  end


  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
    end
  end

  def collections
    owned_collections + followed_collections
  end
end
