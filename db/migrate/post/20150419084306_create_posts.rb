class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
			
			t.string :title
			t.string :content
			t.datetime :published_at
			t.integer :updater_id
			t.boolean :active, null: false, default: true
			t.integer :lock_version, null: false, default: 0
      t.timestamps
    end
  end
end
