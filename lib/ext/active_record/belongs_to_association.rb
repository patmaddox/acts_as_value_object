ActiveRecord::Associations::BelongsToAssociation.class_eval do
  def update_attribute(attribute, new_value)
    old_id = proxy_target.id
    result = proxy_target.update_attribute attribute, new_value
    new_id = proxy_target.id
    if new_id != old_id
      proxy_owner.update_attribute @reflection.primary_key_name, new_id
    end
    result
  end
end
