module ActiveRecord::QueryMethods
	def _where params
		relation = clone
		case
		when params.is_a?(String); return relation
		when params.is_a?(Array); return relation
		when params.is_a?(Hash)
			params = params.map do |field, condition|
				condition = case
				when condition.is_a?(Hash); condition
				when condition.is_a?(Range); { '>=' => condition.begin, '<=' => condition.end }
				when condition.is_a?(Array); { 'in' => condition }
				else; { '=' => condition }
				end
				condition.each do |operator, value|
					{ %[''] => '', %[""] => '', 'true' => true, 'false' => false, 'nil' => nil, 'null' => nil }.each{|x,y| value = y if value == x }
					operator = operator.to_s.downcase
					operator = { 'eq' => '=', 'lt' => '<', 'gt' => '>', 'gteq' => '>=', 'lteq' => '<=', 'noteq' => '!=' }[operator] || operator
					operator = { '=' => 'is', '!=' => 'is not' }[operator] if value === nil
					raise unless field.to_s =~ /^(?:[`'"]?(\w+)[`'"]?\.)?[`'"]?(\w+)[`'"]?$/ && (%w[= > < >= <= != in like is]+['is not']).include?(operator)
					case operator
					when 'like' 
						relation = relation.where("#{self.table_name}.#{field} LIKE '%#{value}%'") if value.present?
					else
						relation = relation.where("#{self.table_name}.#{field} #{operator} #{ operator == 'in' ? '(?)' : '?'}", value) if value.present?
					end
				end
			end
		end
		relation
	end

	def _order params
		params = case
		when params.blank?; "id DESC"
		when params.is_a?(Hash); params.map{ |field, order| "#{field} #{order}" }.join(',')
		when params.is_a?(Array); params.join(',')
		else; params
		end
		raise unless "#{params},".match(/^(?:\s*(?:[`'"]?(\w+)[`'"]?\.)?[`'"]?(\w+)[`'"]?\s*(\sasc|\sdesc)?\s*,\s*)*$/i)
		order params
	end
end
