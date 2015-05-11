class Manage::Account < ActiveRecord::Base
	authenticates_with_sorcery!
	has_one :user, :foreign_key => 'id', class_name: 'User'
	has_one :employee, :foreign_key => 'id', class_name: 'Office::Human::Employee'
	cattr_accessor :manage_fields do %w{name login_at birthday gender}; end
	belongs_to :editor, :foreign_key => 'id', class_name: 'Manage::Editor'
	scope :active, -> { where active: true }
	
	cattr_accessor :manage_fields
	self.manage_fields = %w[name gender brithday pic tag_list password password_confirmation]
	
	delegate :administrations, to: :employee, allow_nil: true
	
	def self.acquire(id)
		record = self.find_by_id(id)
		if !record || record.updated_at < 1.day.ago
			u = User.find_by_id(id)
			( record = self.new; record.id = u.id ) unless record
			record.login_at = Time.now
			record.save
		end
		record
	end
	
	def can? action, resource
		return false unless editor.try(:active?)
		resource = resource.scoped.klass if resource.respond_to?(:scoped)
		resource = resource.class if resource.is_a?(ActiveRecord::Base)
		resource = resource.to_s.underscore.gsub('/', '_')
		@roles ||= (editor.roles + [editor.role]).uniq.compact
		@roles.map { |role| role.can?(action, resource) }.inject(false, &:|)
	end
	
	def method_missing_with_privilege(method, *args)
		if m = method.to_s.match(/^can_([^\_]+)_([^\?]+)\??/)
			return self.can?(m[1], m[2])
		end
		
		method_missing_without_privilege(method, *args)
	end
	
	alias_method_chain :method_missing, :privilege


	def administrator_childs
		administrations.map{ |department| get_department department ; department }
	end


	def get_department depart
		depart.children.map{ |department| get_department department; department }
	end
	
end
