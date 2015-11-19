module ActiveRecord
  class Base
    def self.reset_pk_sequence
      case ActiveRecord::Base.connection.adapter_name
      when "SQLite"
        new_max = maximum(primary_key) || 0
        query = "update sqlite_sequence set seq = #{new_max}"
        query += " where name = '#{table_name}';"
        update_seq_sql = query
        ActiveRecord::Base.connection.execute(update_seq_sql)
      when "PostgreSQL"
        ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
      else
        raise "Task not implemented for this DB adapter"
      end
    end
  end
end
