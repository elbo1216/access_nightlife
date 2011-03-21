# File is used for extensions on any rails/ruby class

module MyActiveRecordExtensions
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # add your static(class) methods here
      def find opts
        sql = self.send(:construct_finder_sql, opts)
        results = self.connection.select_values(sql)
      end
   end
 end

 # include the extension 
 ActiveRecord::Base.send(:include, MyActiveRecordExtensions)
