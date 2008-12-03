require File.dirname(__FILE__) + '/spec_helper'

describe "acts_as_value_object" do
  class Chicken < ActiveRecord::Base
    acts_as_value_object
  end

  it "should define == to check for attributes" do
    Chicken.new(:name => "Bob", :age => 11).should ==
      Chicken.new(:name => "Bob", :age => 11)

    Chicken.new(:name => "Joe", :age => 11).should_not ==
      Chicken.new(:name => "Bob", :age => 11)
  end

  it "should only create one record with the attributes" do
    first = Chicken.create!(:name => "Bob", :age => 11)
    second = Chicken.create!(:name => "Bob", :age => 11)
    Chicken.count.should == 1
    first.should == second
  end
end
