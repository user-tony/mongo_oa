class ChageColumnManageUserToManageRoleColumnManageAccount < ActiveRecord::Migration
  def change
		remove_column :manage_roles, :manage_user
		add_column :manage_roles, :manage_account, :integer, default: 0
  end
end
