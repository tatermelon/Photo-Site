class User < ActiveRecord::Base

  has_many :photos
  has_many :comments
  has_many :tags
  
  validates :login, :presence => true
  validates_uniqueness_of :login
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true
  
  def password
    @password
  end
  
  def password=(pass)
    self.salt = SecureRandom.hex
    @password = pass
    self.password_digest = Digest::SHA1.hexdigest(self.salt + pass)
  end
  
  def password_valid?(candidate)
    digestPass = Digest::SHA1.hexdigest(salt + candidate)
    return digestPass == password_digest
  end
  
end
