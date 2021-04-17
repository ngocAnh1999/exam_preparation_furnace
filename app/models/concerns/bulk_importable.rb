module BulkImportable
  extend ActiveSupport::Concern

  def bulk_import!(record_list)
    raise ArgumentError.new("record_list not an Array of Hashes") unless record_list.is_a?(Array) &&
                                                                         record_list.all? {|rec| rec.is_a? Hash }
    return record_list if record_list.empty?

    (1..record_list.count).step(1000).each do |start|
      key_list, value_list = convert_record_list(record_list[start-1..start+999])
      sql = "INSERT INTO #{self.table_name} (#{key_list.join(", ")}) VALUES #{value_list.map {|rec| "(#{rec.join(", ")})" }.join(" ,")}"
      self.connection.insert(sql)
    end

    return record_list
  end

  def convert_record_list(record_list)
    key_list = record_list.map(&:keys).flatten.map(&:to_s).uniq.sort
                          .select {|x| !x.include? "_attributes" } # tat nested attribute
    value_list = record_list.map do |rec|
      list = []
      key_list.each do |key|
        list << ActiveRecord::Base.connection.quote(rec[key] || rec[key.to_sym])
      end
      list
    end

    time = ActiveRecord::Base.connection.quote(Time.now)
    for field_name in %w(created_at updated_at)
      if self.column_names.include?(field_name) && !(key_list.include?(field_name))
        key_list << field_name
        value_list.each {|rec| rec << time }
      end
    end

    return [key_list, value_list]
  end
end
