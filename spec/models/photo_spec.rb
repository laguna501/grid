require 'spec_helper'
describe Photo do
  describe "relationships" do
    it { should belong_to(:account) }
  end
end
