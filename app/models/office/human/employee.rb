class Office::Human::Employee < ActiveRecord::Base
	belongs_to :department
	belongs_to :company
	belongs_to :creator, class_name: Manage::Account
	belongs_to :updater, class_name: Manage::Account
	has_many :administrations, class_name: Office::Human::Department, foreign_key: 'administrator_id'
	belongs_to :user, class_name: User, foreign_key: 'id'
	
	enum gender: %w[male female], status: %w[formal probationary intern resigned]
	
	validates :identifier, uniqueness: true
	validates :number, numericality: true, uniqueness: true, allow_blank: true
	validates :mobile_phone, format: { with: /^[\d\s-]+$/, multiline: true}, allow_blank: true
	validates :fixed_phone, format: { with: /^[\d\s-]+$/, multiline: true}, allow_blank: true
	validates :probation_month, numericality: true, allow_blank: true
	validates :department, existence: true, allow_blank: true
	validates :company, existence: true, allow_blank: true
	validates :creator, existence: true, allow_blank: true
	validates :updater, existence: true, allow_blank: true
	
	scope :active, -> { where active: true }

	delegate :email, to: :user
	
	cattr_accessor :manage_fields do %w[id name mobile_phone fixed_phone department_id status gender seat_name number position_name identifier company_id city_name probation_month joined_on formalized_on resigned_on]; end
	
	EXPORTS = {
		phone: %w[name mobile_phone fixed_phone created_at updated_at],
		department: { name: 'name', department_id: -> (employee) { employee.department.try(:name) } },
	}
	
	def supervisor
		administrator = department.try(:administrator)
		return administrator if self != administrator
		department.try(:parent).try(:administrator)
	end
	
	def supervisors
		administrator = department.try(:administrator)
		return [administrator] if self != administrator
		administrations.map { |administration| administration.parent.try(:administator) }
	end
end
