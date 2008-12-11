require File.dirname(__FILE__) + '/spec_helper'

describe "acts_as_value_object" do
  describe "objects by themselves" do
    class Email < ActiveRecord::Base
      acts_as_value_object
    end

    it "should define == to check for attributes" do
      Email.new(:address => "bob@example.com", :system_id => 11).should ==
        Email.new(:address => "bob@example.com", :system_id => 11)

      Email.new(:address => "joe@example.com", :system_id => 11).should_not ==
        Email.new(:address => "bob@example.com", :system_id => 11)
    end

    it "should know that unsaved records are equal to saved records with the same attrs" do
      Email.create!(:address => "bob@example.com", :system_id => 11).should ==
        Email.new(:address => "bob@example.com", :system_id => 11)
    end

    it "should only create one record with the attributes" do
      first = Email.create!(:address => "bob@example.com", :system_id => 11)
      second = Email.create!(:address => "bob@example.com", :system_id => 11)
      Email.count.should == 1
      first.should == second
    end

    it "should create a new record when it's updated" do
      c = Email.create!(:address => "bob@example.com", :system_id => 11)
      lambda { c.update_attribute :address, "joe@example.com" }.should change(Email, :count).by(1)
    end
  end

  describe "belongs_to associations" do
    class Order < ActiveRecord::Base
      belongs_to :email
    end

    class Email < ActiveRecord::Base
      acts_as_value_object
    end

    before(:each) do
      @email = Email.create! :address => "joe@example.com", :system_id => 123
      @order = Order.create! :email => @email
    end

    it "should update the reference when changed with save" do
      @order.email.address = "newaddress@example.com"
      @order.email.save
      @order.reload.email.address.should == "newaddress@example.com"
    end    

    it "should update the reference when changed with save" do
      @order.email.address = "newaddress@example.com"
      @order.email.save!
      @order.reload.email.address.should == "newaddress@example.com"
    end    

    it "should update the reference when changed with update_attribute" do
      @order.email.update_attribute :address, "newaddress@example.com"
      @order.reload.email.address.should == "newaddress@example.com"
    end

    it "should update the reference when changed with update_attributes" do
      @order.email.update_attributes :address => "newaddress@example.com"
      @order.reload.email.address.should == "newaddress@example.com"
    end

    [:save, :save!, :update_attribute, :update_attributes].each do |method_name|
      it "should not screw with the arity of #{method_name}" do
        ActiveRecord::Associations::BelongsToAssociation.instance_method(method_name).arity.should ==
          ActiveRecord::Base.instance_method(method_name).arity
      end
    end
  end
end
