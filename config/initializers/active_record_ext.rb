class ActiveRecord::Base
	# cattr_accessor :manage_fields

	def read(options={})
		self.readings.create(options)
	end

	def updated(options={})
		self.updatings.create(options)
	end

	def updated!(options={})
		self.updatings.create!(options)
	end

	def destroy_softly
		self.active = false
		# self.destroyed_at = Time.now
		self.save#_without_validation#_and_timestamping
	end

	def self.f(id)
		record = where(id: id)
		record = record.where(active: true) if record.first.respond_to?(:active?)
		record.first
	end

	def self.acquire(id)
		f(id)
	end

	WHERE_LAMBDA = lambda { |params|
		params = case
		when params.is_a?(String); #params
		when params.is_a?(Array); #params
		when params.is_a?(Hash)
			params = params.map do |field, condition|
				condition = case
				when condition.is_a?(Hash); condition
				when condition.is_a?(Range); { '>=' => condition.begin, '<=' => condition.end }
				when condition.is_a?(Array); { 'in' => condition }
				else; { '=' => condition }
				end
				condition.map do |operator, value|
					{ %[''] => '', %[""] => '', 'true' => true, 'false' => false, 'nil' => nil, 'null' => nil }.each{|x,y| value = y if value == x }
					operator = operator.to_s.downcase
					operator = { 'eq' => '=', 'lt' => '<', 'gt' => '>', 'gteq' => '>=', 'lteq' => '<=', 'noteq' => '!=' }[operator] || operator
					operator = { '=' => 'is', '!=' => 'is not' }[operator] if value === nil
					raise unless field.to_s =~ /^(?:[`'"]?(\w+)[`'"]?\.)?[`'"]?(\w+)[`'"]?$/ && (%w[= > < >= <= != in like is]+['is not']).include?(operator)
					["#{field} #{operator} #{value.is_a?(Array) ? '(?)' : '?'}", value]
				end.compact
			end
			params.inject([], &:+).inject{|a, b| a[0] = [a[0], b[0]].join(' AND '); a << b[1]; a }
		end
		{ :conditions => params }
	}

	ORDER_LAMBDA = lambda { |params|
		params = case
		when params.blank?; "id DESC"
		when params.is_a?(Hash); params.map{ |field, order| "#{field} #{order}" }.join(',')
		when params.is_a?(Array); params.join(',')
		else; params
		end
		raise unless "#{params},".match(/^(?:\s*(?:[`'"]?(\w+)[`'"]?\.)?[`'"]?(\w+)[`'"]?\s*(\sasc|\sdesc)?\s*,\s*)*$/i)
		{ :order => params }
	}

	scope :_where, WHERE_LAMBDA
	scope :_order, ORDER_LAMBDA

	def self.default(params, options = {})
		active
			._where(params[:where])
			._order(params[:order])
			.page(params[:page])
			.per(params[:per_page])
	end

	def self.find_by(options)
		where(options).first
	end

	def self.pagi(params)
		paginate(page: params[:page], per_page: params[:per_page])
	end

end
