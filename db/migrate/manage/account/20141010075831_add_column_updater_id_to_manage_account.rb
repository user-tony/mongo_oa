class AddColumnUpdaterIdToManageAccount < ActiveRecord::Migration
  def change
		add_column :manage_accounts, :updater_id, :integer
  end
end
