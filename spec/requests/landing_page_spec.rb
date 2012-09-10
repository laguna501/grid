# encoding: UTF-8
require 'request_spec_helper'

describe "Test Landing page which branches out to Pros and Girls", js: true do
  describe "Landing page" do
    it "As an user I want to see landing" do
      visit ("/")
      current_path.should == "/"
      page.should have_css("#grid" , :text => "Grid")
      page.should have_css("#grid" , :text => "Pro Grid")
      page.should have_css("#grid" , :text => "Girl Grid")
    end
  end
end