class CreateOfficeHumanDepartments < ActiveRecord::Migration
  def change
    create_table :office_human_departments do |t|
      t.string :name
      t.string :english_name
      t.text :description
      t.integer :administrator_id
      t.integer :parent_id
      t.integer :company_id
      t.integer :creator_id
      t.integer :updater_id
      t.boolean :active, null: false, default: true
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end
  end
end
