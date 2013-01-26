class CreateTags < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.column :id,         :string
      t.column :user_id,    :string
      t.column :photo_id,   :string
      t.column :x_coord,    :integer
      t.column :y_coord,    :integer
      t.column :width,      :integer
      t.column :height,     :integer
    end
  end
  
  def down
    drop_table :tags
  end
end
