class AddColumnUserToManageRoles < ActiveRecord::Migration
  def change
    add_column :manage_roles, :user, :integer, default: 0
  end
end
