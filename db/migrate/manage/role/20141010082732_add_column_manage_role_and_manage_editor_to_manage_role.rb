class AddColumnManageRoleAndManageEditorToManageRole < ActiveRecord::Migration
  def change
		add_column :manage_roles, :manage_editor, :integer, default: 0
		add_column :manage_roles, :manage_role, :integer, default: 0
  end
end
