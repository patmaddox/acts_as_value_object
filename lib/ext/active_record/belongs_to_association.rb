ActiveRecord::Associations::BelongsToAssociation.class_eval do
  def self.delegate_to_proxy_with_value_object_checking(*method_names)
    method_names.each do |method_name|
      arg_names = []
      arity = ActiveRecord::Base.instance_method(method_name).arity
      if arity == -1
        arg_names << "*args"
      else
        arity.times {|i| arg_names << "arg#{i}" }
      end
      arg_names << "&block"
      args = arg_names.join ', '
      
      definition = <<-METHOD_DEF
        def #{method_name}(#{args})
          old_id = proxy_target.id
          result = proxy_target.send(:#{method_name}, #{args})
          new_id = proxy_target.id
          if new_id != old_id
            proxy_owner.update_attribute @reflection.primary_key_name, new_id
          end
          result
        end
      METHOD_DEF
      class_eval definition
    end
  end

  delegate_to_proxy_with_value_object_checking :save, :save!, :update_attribute, :update_attributes
end
