class AddColumnPasswordToManageAccounts < ActiveRecord::Migration
  def change
		add_column :manage_accounts, :password, :string
  end
end
