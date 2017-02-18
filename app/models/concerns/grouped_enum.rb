module GroupedEnum
  include ActiveSupport::Concern

  class_methods do
    def grouped_enum(definitions)
      # klass = self

      # define *_grouped class method
      # useful for displaying to the user
      # definitions.each do |k,v|
      #   # name = [k.to_s.pluralize, 'grouped'].join(?_)
      #   # puts "   defining #{name}..."
      #   # klass.singleton_class.send(:define_method, name) { v }
      #   v.each do |b,s|
      #     case s
      #     when Hash
      #       klass.scope b, -> { where(v => s.values) }
      #     end
      #   end
      # end

      # define base enum (by flattening groups)
      enum Hash[definitions.map do |k,v|
        [k, Hash[v.flat_map do |b,s|
          case s
          when Hash
            s.map do |sk,sv|
              [[sk,b].join(?_).to_sym, sv]
            end
          when Fixnum
            [[b, s]]
          end
        end]]
      end]
    end
  end
end
