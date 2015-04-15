class CreateOfficeHumanCompanies < ActiveRecord::Migration
	def change
		create_table :office_human_companies do |t|
			t.string :name
			t.text :description
			t.string :fixed_phone
			t.boolean :active, null: false, default: true
			t.integer :lock_version, null: false, default: 0
			t.integer :creator_id
			t.integer :updater_id
			t.integer :parent_id

			t.timestamps
		end
	end
end
