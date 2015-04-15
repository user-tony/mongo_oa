class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
	    t.string   "name"
	    t.string   "gender"
	    t.string   "pic"
	    t.date     "birthday"
	    t.datetime "login_at"
	    t.integer  "lock_version",               :default => 0
	    t.integer  "level_id",                   :default => 1
	    t.integer  "editor_id"
      t.timestamps
    end
  end
end
