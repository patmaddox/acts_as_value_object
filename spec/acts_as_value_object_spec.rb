require File.dirname(__FILE__) + '/spec_helper'

describe "acts_as_value_object" do
  class Chicken < ActiveRecord::Base
    acts_as_value_object
  end
end
