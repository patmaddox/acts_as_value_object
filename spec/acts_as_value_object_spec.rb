require File.dirname(__FILE__) + '/spec_helper'

describe "acts_as_value_object" do
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
