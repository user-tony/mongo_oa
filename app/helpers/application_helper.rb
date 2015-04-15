module ApplicationHelper
	def can? *argv
		@current_user && @current_user.respond_to?(:can?) && @current_user.can?(*argv)
	end

	def model
		@model ||= self.controller.model
	end

	def t(key, options = {})
		# If the user has specified rescue_format then pass it all through, otherwise use
		# raise and do the work ourselves
		options[:raise] = true unless options.key?(:raise) || options.key?(:rescue_format)
		if html_safe_translation_key?(key)
			html_safe_options = options.dup
			options.except(*I18n::RESERVED_KEYS).each do |name, value|
				unless name == :count && value.is_a?(Numeric)
					html_safe_options[name] = ERB::Util.html_escape(value.to_s)
				end
			end
			translation = I18n.translate(scope_key_by_partial(key), html_safe_options)

			translation.respond_to?(:html_safe) ? translation.html_safe : translation
		else
			I18n.translate(scope_key_by_partial(key), options)
		end
	rescue I18n::MissingTranslationData => e
		keys = I18n.normalize_keys(e.locale, e.key, e.options[:scope])
		keys.last.to_s.titleize
	end

	def set_seo(options = {})
		content_for :title, options[:title] ? "#{SEO['title']}_#{options[:title]}" : SEO['title']
		content_for :keywords, options[:keywords] ? "#{SEO['keywords']}_#{options[:keywords]}" : SEO['keywords']
		content_for :description, options[:description] ? "#{SEO['description']}_#{options[:description]}" : SEO['description']
	end

	def link_to_tag record
		raw <<-HTML
		#{raw record.cached_tag_list.to_s.split(',').map{|tag| link_to tag, searches_path(keyword: tag, flag: record.class.to_s.underscore.to_s.tableize), title: tag, target: '_blank'}.join(' ')}
		HTML
	end

	def paginate_array(num, page, per=10)
		Kaminari.paginate_array(Array.new(num)).page(page).per(per)
	end

	def rand_time(from, to=Time.now)
		Time.at(rand_in_range(from.to_f, to.to_f))
	end

	def rand_in_range(from, to)
		rand * (to - from) + from
	end
end
