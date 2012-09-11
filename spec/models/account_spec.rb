require 'spec_helper'
describe Account do
  describe "relationships" do
    it { should belong_to(:user) }
    it { should have_many(:photos) }
  end
end
