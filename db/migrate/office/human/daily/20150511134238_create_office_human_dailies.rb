class CreateOfficeHumanDailies < ActiveRecord::Migration
  def change
    create_table :office_human_dailies do |t|
			t.string :title
			t.string :name
			t.string :task
			t.string :issue
			t.string :summary
			t.string :plan
			t.boolean :notified
			t.datetime :notified_at
			t.integer :creator_id
			t.integer :department_id
			t.integer :administrator_id
			t.string :remark
			t.integer :updater_id
			t.boolean :active, null: false, default: true
			t.integer :lock_version, null: false, default: 0
      t.timestamps
    end
  end
end
