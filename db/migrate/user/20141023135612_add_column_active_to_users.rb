class AddColumnActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active, :boolean, default: true
    add_column :users, :updater_id, :integer
  end
end
