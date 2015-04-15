class Common::InterfacesController < ApplicationController

	layout false
	respond_to :json
	
	# caches_action :stars, :expires_in => 12.hours, :cache_path => Proc.new { |controller| controller.request.fullpath }

	def search
		keyword = params[:keyword].to_s.strip.gsub(/[\+\-\&\|\!\(\)\{\}\[\]\^\"\~\*\?\:\\]/){|c|"\\"+c}
		body = Search.engines(params[:flag]).map{|record| Search.query(keyword, record)}
		render layout: false, json: body.present? ? body.compact : ''
	end

	def tags
	end

	# Tag.get_hottag
	#
	# 	{
	#			"tagInfo"=> "阅读:6824.0,成绩:6102.0,信息:5698.0"
	#			"tagItem"=>"考试",
	#			"weight"=>"12342.0"
	#		}
	#
	def relaction_tags
    render json: { '千帆渡' => Tag.relaction_tag_json }
	end

	def stars
		render json: { stars: Search::Tag.limit(params[:limit]||1000).map{ |tag| {c: format("%3.f", rand(1000)), d: format("%3.f", rand(1000)), dec: format("%2.f", rand(1000)), name: tag.name, ra: format("%2.f", rand(100))} }  }
	end

	def reading_increment
		record = case params[:flag]
		when 'question' then Read::Question.acquire params[:id]	
		when 'news' then Read::News.acquire params[:id]
		end
		record.increment!(:readings_count) rescue ''
		render text: 'scueess'
	end
end
