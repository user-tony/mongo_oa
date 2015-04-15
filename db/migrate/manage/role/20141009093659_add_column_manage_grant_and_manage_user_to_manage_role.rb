class AddColumnManageGrantAndManageUserToManageRole < ActiveRecord::Migration
  def change
		add_column :manage_roles, :manage_user, :integer,  default: 0
		add_column :manage_roles, :manage_grant, :integer,  default: 0
  end
end
