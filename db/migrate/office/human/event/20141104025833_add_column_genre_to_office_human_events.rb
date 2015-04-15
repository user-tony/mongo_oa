class AddColumnGenreToOfficeHumanEvents < ActiveRecord::Migration
  def change
      add_column :office_human_events, :genre, :string
      add_column :office_human_events, :color, :string
      add_column :office_human_events, :updater_id, :integer
      add_column :office_human_events, :published, :boolean, default: false
      add_column :office_human_events, :active, :boolean, default: true
      add_column :office_human_events, :lock_version, :integer, default: 0
      rename_column :office_human_events, :body, :description
  end
end
