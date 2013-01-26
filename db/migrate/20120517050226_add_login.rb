class AddLogin < ActiveRecord::Migration
  def up
    add_column :users, :login, :string
    User.reset_column_information
    User.find(:all).each do |u|
        u.update_attribute :login, u[:last_name].downcase()		
    end
  end

  def down
    remove_column :users, :login
  end
end
