class Factory
  def self.new(*attrs, &block)
    new_class = Class.new do
      attrs.each do |a| 
        instance_variable_set(:"@#{a}", nil) 
        attr_accessor :"#{a}"
      end

      define_method :initialize do |*v|
        attrs.each_with_index { |a, i| instance_variable_set(:"@#{a}", v[i])}
      end

      def [](a)
        instance_variable_get "@#{a}"
      end

      def []=(a, value)
        instance_variable_set("@#{a}", value)
      end

      def values 
        instance_variables.map { |a| instance_variable_get("#{a}") }
      end

      def ==(a)
        self.class == a.class && values == a.values
      end

      def values_at(*args)
        args.map { |a| values[a]}
      end

      def to_h
        result = {}
        instance_variables.map { |v| result.merge! "#{v}".slice!(1..-1).to_sym => instance_variable_get("#{v}")}
        result
      end

      def members 
        instance_variables.map { |v| v.to_sym}
      end

      def lenght 
        members.count
      end

      def select &block
        to_a.select &block
      end

      def eql?(other)
        self.class == other.class && values.eql?(other.values)
      end

      def each(&block)
        return to_enum(__method__) unless block_given?
          members.each(&block)
        end

      def each_pair(&block)
        return to_enum(__method__) unless block_given?
            members.each { |m| yield(m, instance_variable_get("#{m}")) }
      end

      alias_method :size, :lenght
      alias_method :to_a, :values

      class_eval(&block) if block
    end
  end
end

