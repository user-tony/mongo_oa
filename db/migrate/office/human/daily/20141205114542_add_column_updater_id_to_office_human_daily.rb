class AddColumnUpdaterIdToOfficeHumanDaily < ActiveRecord::Migration
  def change
    add_column :office_human_dailies, :updater_id, :integer
  end
end
