module ActsAsValueObject
  module ClassMethods
    def acts_as_value_object
      include ActsAsValueObject::InstanceMethods
      before_save :load_from_existing
    end
  end

  module InstanceMethods
    def ==(other)
      self.class == other.class &&
        self.attributes == other.attributes
    end

    def load_from_existing
      if existing = find_by_my_attributes
        @new_record = false
        self.id = existing.id
      end
    end

    def find_by_my_attributes
      attribute_names = []
      attribute_values = []
      attributes.each do |key, v|
        attribute_names << key
        attribute_values << v
      end
      finder = "find_by_" + attribute_names.join('_and_')
      self.class.send(finder, *attribute_values)
    end
  end
end

ActiveRecord::Base.extend ActsAsValueObject::ClassMethods
