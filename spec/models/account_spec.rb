require 'spec_helper'
describe Account do
  describe "relationships" do
    it { should belong_to(:user) }
    it { should have_many(:photos) }
    it "destroy photos on destroy" do
      account = FactoryGirl.create(:account)
      account.photos << FactoryGirl.create(:photo)
      lambda {
        account.destroy
      }.should change(Photo, :count).by(-1)
    end
  end
end
