class ActiveRecord::Relation
  def each_batch(options, &block)
    records = clone
    (options[:times].to_i).to_i.times do |i|
      records = records.limit(options[:size]).offset(options[:size]*(i+1))
      break if records.blank?
      yield(records) if block
    end
  end
end
