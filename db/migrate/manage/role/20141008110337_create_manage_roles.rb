class CreateManageRoles < ActiveRecord::Migration
	def change
		create_table :manage_roles do |t|
			t.integer  :user_id
			t.string   :name
			t.text     :description
			t.datetime :destroyed_at
			t.integer :updater_id
			t.boolean :active, null: false, default: true
			t.integer :lock_version, null: false, default: 0
			t.timestamps
		end
	end
end
