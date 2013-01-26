class AddPasswords < ActiveRecord::Migration
  def up
    add_column :users, :password_digest, :string
    add_column :users, :salt, :string
    User.reset_column_information
    User.find(:all).each do |u|
      salt = SecureRandom.hex
      saltedPassword = salt + u[:first_name].downcase()
      encryptedPassword = Digest::SHA1.hexdigest(saltedPassword)
      u.update_attribute :password_digest, encryptedPassword
      u.update_attribute :salt, salt
    end
  end

  def down
    remove_column :users, :password_digest
    remove_column :users, :salt
  end
end