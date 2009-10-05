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
      when String then
        "s:#{object.length}:\"#{object}\";"
      when Array then
        idx   = -1
        items = object.map { |item| "#{run(idx += 1)}#{run(item)}" }.join
        "a:#{object.length}:{#{items}};"
      when Hash then
        items = object.map { |key,value| "#{run(key)}#{run(value)}" }.join
        "a:#{object.length}:{#{items}};"
      else
        klass_name = object.class.name
        attributes = object.instance_variables.map { |var_name| "#{run(var_name.gsub(/^@/, ''))}#{run(object.instance_variable_get(var_name))}" }
        "O:#{klass_name.length}:\"#{klass_name}\":#{object.instance_variables.length}:{#{attributes}};"
      end
    end  
  end
end