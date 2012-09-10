# encoding: UTF-8
require 'request_spec_helper'

describe "Test Pro Grid and Girl Grid page", js: true do
  describe "Pro page" do
    it "As an user I want to see Pro page when I clicked button" do
      visit ("/")
      current_path.should == "/"
      click_link ('Pro Grid')
      current_path == "/grids/show_users?type=pro"
      page.should have_css("#show_users", :text => "Pro Grid")
    end
  end
  describe "Girl page" do
  	it "As an user I want to see Girl page when I clicked button" do
  	  visit ("/")
  	  current_path.should == "/"
      click_link ('Girl Grid')
      current_path == "/grids/show_users?type=girl"
      page.should have_css("#show_users", :text => "Girl Grid")
  	end
   end
end
