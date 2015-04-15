class AddColumnOfficeHumanCompanyToManageRoles < ActiveRecord::Migration
  def change
		add_column :manage_roles, :office_human_company, :integer, default: 0
		add_column :manage_roles, :office_human_department, :integer, default: 0
		add_column :manage_roles, :office_human_employee, :integer, default: 0
  end
end
