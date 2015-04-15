class CreateOfficeHumanEmployees < ActiveRecord::Migration
	def change
		create_table :office_human_employees do |t|
			t.string :name
			t.string :identifier
			t.string :mobile_phone
			t.string :fixed_phone
			t.integer :department_id
			t.integer :company_id
			t.string :seat_name
			t.integer :gender
			t.integer :number
			t.integer :status
			t.date :joined_on
			t.date :formalized_on
			t.string :position_name
			t.string :city_name
			t.boolean :active, null: false, default: true
			t.integer :lock_version, null: false, default: 0
			t.integer :probation_month
			t.integer :creator_id
			t.integer :updater_id
			t.date :resigned_on
			t.timestamps
		end
	end
end
