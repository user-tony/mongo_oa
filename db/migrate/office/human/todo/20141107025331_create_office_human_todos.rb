class CreateOfficeHumanTodos < ActiveRecord::Migration
  def change
    create_table :office_human_todos do |t|
        t.integer :updater_id
        t.string :title
        t.string :genre
        t.text :description
        t.boolean :active
        t.integer :position, default: 0
        t.boolean :active, null: false, default: true
        t.boolean :published, default: false
      t.timestamps
    end
  end
end
