class SorceryCore < ActiveRecord::Migration
  def change
		add_column :users, :email, :string
		add_column :users, :salt, :string
		add_column :users, :crypted_password, :string
    add_index :users, :email, unique: true
  end
end