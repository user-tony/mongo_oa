class CreateManageEditors < ActiveRecord::Migration
	def change
		create_table :manage_editors, force: true do |t|
			t.integer  :user_id
			t.string   :name
			t.integer  :role_id
			t.datetime :destroyed_at
			t.integer  :lock_version,  :default => 0
			t.string   :identifier
			t.boolean :active, null: false, default: true
			t.integer :lock_version, null: false, default: 0
			t.timestamps
		end
	end
end
