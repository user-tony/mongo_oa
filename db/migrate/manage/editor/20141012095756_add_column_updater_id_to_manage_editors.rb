class AddColumnUpdaterIdToManageEditors < ActiveRecord::Migration
  def change
		add_column :manage_editors, :updater_id, :integer
  end
end
