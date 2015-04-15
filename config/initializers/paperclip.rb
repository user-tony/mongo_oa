module Paperclip
	module Interpolations
		def style_extension attachment, style_name
			style_name && style_name != :original ? ".#{style_name}.jpg" : ''
		end
	end

	module ClassMethods
		def has_attached_file_with_patch(name, options = {})
			attributes = %w[file_name file_size content_type updated_at image_width image_height]
			self.cattr_accessor *(["#{name}_attachment"] + attributes.map { |field| "#{name}_attachment_#{field}" })

			has_attached_file("#{name}_attachment", options)

			define_method "#{name}=" do |file|
				if file.respond_to?(:read)
					if geometry = Paperclip::Geometry.from_file(file) rescue nil
						self.send("#{name}_attachment_image_width=", geometry.width) if self.respond_to?("#{name}_attachment_image_width")
						self.send("#{name}_attachment_image_height=", geometry.height) if self.respond_to?("#{name}_attachment_image_height")
					end
					self.send("#{name}_attachment=", file)
					self[name] = self.send("#{name}_attachment").url(:original, false)
					%w[file_name file_size content_type updated_at image_width image_height].each { |field| self["#{name}_#{field}"] = self.send("#{name}_attachment_#{field}") || self["#{name}_attachment_#{field}"] if self.respond_to?("#{name}_#{field}") }
				elsif file.blank?
					self[name] = nil
					%w[file_name file_size content_type updated_at image_width image_height].each { |field| self["#{name}_#{field}"] = nil if self.respond_to?("#{name}_#{field}") }
				else
					self[name] = file.to_s.gsub(/^.*:\//, '')
				end
			end

			define_method "_#{name}_after_create" do
				url = self.send("#{name}_attachment").url(:original, false)
				if url && url != self[name] && url !~ /original\/missing\.png/
					self[name] = url
					self.save
				end
			end
			after_create "_#{name}_after_create"
		end
	end

	module Validators
		class AttachmentContentTypeValidator < ActiveModel::EachValidator
			def validate_each_with_patch(record, attr_name, value)
				validate_each_without_patch(record, attr_name, value)
				(record.errors["#{attr_name}_content_type"] || []).each { |error| record.errors.add(attr_name.to_s.sub(/_attachment$/, ''), 'content type ' + error) }
			end
			alias_method_chain :validate_each, :patch
		end

		class AttachmentSizeValidator < ActiveModel::Validations::NumericalityValidator
			def validate_each_with_patch(record, attr_name, value)
				validate_each_without_patch(record, attr_name, value)
				(record.errors["#{attr_name}_file_size"] || []).each { |error| record.errors.add(attr_name.to_s.sub(/_attachment$/, ''), 'file size ' + error) }
			end
			alias_method_chain :validate_each, :patch
		end

		class AttachmentImageWidthValidator < ActiveModel::Validations::NumericalityValidator
			def self.helper_method_name
				:validates_attachment_image_width
			end
			def validate_each(record, attr_name, value)
				base_attr_name = attr_name
				attr_name = "#{attr_name}_image_width".to_sym
				value = record[attr_name]
				super(record, attr_name, value) unless value.blank?
				(record.errors[attr_name] || []).each { |error| record.errors.add(base_attr_name.to_s.sub(/_attachment$/, ''), 'image width ' + error) }
			end
		end

		class AttachmentImageHeightValidator < ActiveModel::Validations::NumericalityValidator
			def self.helper_method_name
				:validates_attachment_image_height
			end
			def validate_each(record, attr_name, value)
				base_attr_name = attr_name
				attr_name = "#{attr_name}_image_height".to_sym
				value = record[attr_name]
				super(record, attr_name, value) unless value.blank?
				(record.errors[attr_name] || []).each { |error| record.errors.add(base_attr_name.to_s.sub(/_attachment$/, ''), 'image height ' + error) }
			end
		end

		module HelperMethods
			def validates_attachment_image_width(*attr_names)
				options = _merge_attributes(attr_names)
				validates_with AttachmentImageWidthValidator, options.dup
				validate_before_processing AttachmentImageWidthValidator, options.dup
			end

			def validates_attachment_image_height(*attr_names)
				options = _merge_attributes(attr_names)
				validates_with AttachmentImageHeightValidator, options.dup
				validate_before_processing AttachmentImageHeightValidator, options.dup
			end
		end

		module ClassMethods
			def validates_attachment_with_patch(*attributes)
				options = attributes.extract_options!.dup
				attributes.map! { |attribute| "#{attribute}_attachment".to_sym }
				validates_attachment(attributes + [options])
			end
		end
	end
end
