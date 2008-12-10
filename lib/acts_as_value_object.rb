require 'digest/md5'

module ActsAsValueObject
  module ClassMethods
    def acts_as_value_object
      include ActsAsValueObject::InstanceMethods
      before_validation_on_create :set_md5
      before_save :load_from_existing
    end
  end

  module InstanceMethods
    def ==(other)
      self.class == other.class &&
        self.attributes == other.attributes
    end

    def load_from_existing
      if existing = self.class.find_by_md5(to_md5)
        @new_record = false
        self.id = existing.id
      end
    end

    def to_md5
      hashable_attrs = attributes.clone
      hashable_attrs.delete "md5"
      hashable_attrs.delete "id"
      Digest::MD5.hexdigest(hashable_attrs.to_s)
    end

    private
    def set_md5
      self.md5 = to_md5
    end
  end
end

ActiveRecord::Base.extend ActsAsValueObject::ClassMethods
