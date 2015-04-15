class CreateManageGrants < ActiveRecord::Migration
	def change
		create_table :manage_grants, force: true do |t|
			t.integer :editor_id
			t.integer  :role_id
			t.integer :updater_id
			t.boolean :active, null: false, default: true
			t.integer :lock_version, null: false, default: 0
			t.timestamps
		end

		add_index "manage_grants", ["active", "editor_id", "role_id"], name: "by_active_and_editor_id_and_role_id"
	end
end
