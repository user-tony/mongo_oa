# 账号表
class Manage::Account < ActiveRecord::Base
  # 添加账号难方法
	authenticates_with_sorcery!
  # 关联用户关系表
	has_one :user, :foreign_key => 'id', class_name: 'User'
  # 关联办公系统人员表
	has_one :employee, :foreign_key => 'id', class_name: 'Office::Human::Employee'
  # 关联编辑表
	belongs_to :editor, :foreign_key => 'id', class_name: 'Manage::Editor'

  # 查询所有有效数据
	scope :active, -> { where active: true }
	
  # 建立好
	cattr_accessor :manage_fields
	self.manage_fields = %w[name gender brithday pic tag_list password password_confirmation]
	
  # 代理方法， 关联OA人员
	delegate :administrations, to: :employee, allow_nil: true
	
  
  # 查询方法并记录登陆时间 
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
  
  def name
    tries(:user, :name)
  end
	
  
  # 权限判断方法
	def can? action, resource
		return false unless editor.try(:active?)
		resource = resource.scoped.klass if resource.respond_to?(:scoped)
		resource = resource.class if resource.is_a?(ActiveRecord::Base)
		resource = resource.to_s.underscore.gsub('/', '_')
		@roles ||= (editor.roles + [editor.role]).uniq.compact
		@roles.map { |role| role.can?(action, resource) }.inject(false, &:|)
	end
	
  # 匹配判断通用方法
	def method_missing_with_privilege(method, *args)
		if m = method.to_s.match(/^can_([^\_]+)_([^\?]+)\??/)
			return self.can?(m[1], m[2])
		end
		
		method_missing_without_privilege(method, *args)
	end
	
	alias_method_chain :method_missing, :privilege


  #  获取所有部门
	def administrator_childs
		administrations.map{ |department| get_department department ; department }
	end

  # 
	def get_department depart
		depart.children.map{ |department| get_department department; department }
	end
	
end
