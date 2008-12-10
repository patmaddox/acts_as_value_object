require 'digest/md5'
file = File.dirname(__FILE__)
require "#{file}/ext/active_record/belongs_to_association"

module ActsAsValueObject
  module ClassMethods
    def acts_as_value_object
      include ActsAsValueObject::InstanceMethods
      before_save :set_md5
      before_save :load_from_existing
    end
  end

  module InstanceMethods
    def ==(other)
      self.class == other.class &&
        self.comparable_attributes == other.comparable_attributes
    end

    def load_from_existing
      if existing = self.class.find_by_md5(to_md5)
        @new_record = false
        self.id = existing.id
      else
        @new_record = true
        self.id = nil
      end
    end

    def comparable_attributes
      comparable_attrs = attributes.clone
      comparable_attrs.delete "md5"
      comparable_attrs.delete "id"
      comparable_attrs
    end

    def to_md5
      Digest::MD5.hexdigest(comparable_attributes.to_s)
    end

    private
    def set_md5
      self.md5 = to_md5
    end
  end
end

ActiveRecord::Base.extend ActsAsValueObject::ClassMethods
