
module CommonClassHelpers
  
  def class_attr_accessor(*names)
    names.each do |name|
      class_variable_set("@@#{name.to_s}", nil)

      define_singleton_method("#{name.to_s}=".to_sym) do |attr|
        class_variable_set("@@#{name.to_s}", attr)
      end
      
      define_singleton_method(name.to_sym) do
        class_variable_get("@@#{name.to_s}")
      end
    end
  end

end


module CommonInstanceHelpers
  
  def full_method_name(module_name, method_name)
    "#{module_name}.#{method_name}"
  end

  def base64?(value)
    value.is_a?(String) && (Base64.encode64(Base64.decode64(value)).strip == value)
  end

  def encode_to_base64(message)
    Base64.encode64(message.force_encoding('UTF-8')).strip
  end
end

class << Object
  def private_accessor(*names)
    names.each do |name|
      attr_accessor name
      private "#{name}="
    end
  end
end