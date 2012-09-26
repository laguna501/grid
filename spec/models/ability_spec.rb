require 'spec_helper'
describe Ability do
  context "admin" do
    subject {
      @admin = FactoryGirl.build(:admin)
      Ability.new(@admin)
    }

    it "can manage all" do
     end
	end
end