class AddColumnPostToManageRoles < ActiveRecord::Migration
  def change
		add_column :manage_roles, :post, :integer, default: 0
  end
end
