module PhpSerialization
  class Serializer
    def run(object)
      case object
      when NilClass then
        "N;"
      when TrueClass then
        "b:1;"
      when FalseClass then
        "b:0;"
      when Integer then
        "i:#{object};"
      when Float then
        "d:#{object};"
      when String, Symbol then
        "s:#{object.to_s.bytesize}:\"#{object}\";"
      when Array then
        idx   = -1
        items = object.map { |item| "#{run(idx += 1)}#{run(item)}" }.join
        "a:#{object.length}:{#{items}}"
      when Hash then
        items = object.map { |key,value| "#{run(key)}#{run(value)}" }.join
        "a:#{object.length}:{#{items}}"
      else
        klass_name = object.class.name

        if klass_name =~ /^Struct::/ && php_klass = object.instance_variable_get("@_php_class")
          klass_name = php_klass
        end

        attributes = object.instance_variables.sort.map { |var_name| "#{run(var_name.to_s.gsub(/^@/, ''))}#{run(object.instance_variable_get(var_name))}" }
        "O:#{klass_name.length}:\"#{klass_name}\":#{object.instance_variables.length}:{#{attributes.join}}"
      end
    end
  end
end
