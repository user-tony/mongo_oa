class AddColumnDailyToManageRoles < ActiveRecord::Migration
  def change
		add_column :manage_roles, :office_human_daily, :integer, default: 0
  end
end
