# encoding: UTF-8
require 'request_spec_helper'

describe "Test Pro Grid and Girl Grid page", js: true do
  describe "Pro page" do
    it "I want to see Pro page when I clicked button" do
      visit ("/")
      current_path.should == "/"
      click_link ('Pro Grid')
      current_path == "/grids/show_users?type=pro"
      page.should have_css("#show_users", :text => "Pro Grid")
    end
    it "I want to see photos from Facebook in Pro page" do
      user = FactoryGirl.create(:user, email: "artiwarah@example.com",user_type: "pro", nickname: "JOE")
      account = FactoryGirl.create(:account,username: "artiwarah", type: "FacebookAccount", user: user)
      photo = FactoryGirl.create(:photo, 
        identifier: '1',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg", 
        account: account
        )

      visit ("/")
      current_path.should == "/"
      page.should have_css("#grid" , :text => "Pro Grid")
      click_link ('Pro Grid')
      page.should have_css("img[@alt='182869_3569852204790_1354565865_n']")
    end
    it "I want to see photos from Instagram in Pro page" do
      user = FactoryGirl.create(:user, email: "Chanisa@example.com",user_type: "pro", nickname: "FERN")
      account = FactoryGirl.create(:account,username: "fernzzzaa", type: "InstagramAccount", user: user)
      photo = FactoryGirl.create(:photo, 
        identifier: '2',
        thumbnail: "/assets/uploads/instagram/thumbnail/fernzzzaa/04112eeafbca11e1968922000a1cf73c_7.jpg",
        full: "/assets/uploads/instagram/full/fernzzzaa/04112eeafbca11e1968922000a1cf73c_6.jpg", 
        account: account
        )

      visit ("/")
      current_path.should == "/"
      page.should have_css("#grid" , :text => "Pro Grid")
      click_link ('Pro Grid')
      page.should have_css("img[@alt='04112eeafbca11e1968922000a1cf73c_7']")
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
    it "I want to see photos from Facebook in Girl page" do
      user = FactoryGirl.create(:user, email: "artiwarah@example.com",user_type: "girl", nickname: "JOE")
      account = FactoryGirl.create(:account,username: "artiwarah", type: "FacebookAccount", user: user)
      photo = FactoryGirl.create(:photo, 
        identifier: '3',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg", 
        account: account
        )

      visit ("/")
      current_path.should == "/"
      page.should have_css("#grid" , :text => "Girl Grid")
      click_link ('Girl Grid')
      page.should have_css("img[@alt='182869_3569852204790_1354565865_n']")
    end
    it "I want to see photos from Instagram in Girl page" do
      user = FactoryGirl.create(:user, email: "Chanisa@example.com",user_type: "girl", nickname: "FERN")
      account = FactoryGirl.create(:account,username: "fernzzzaa", type: "InstagramAccount", user: user)
      photo = FactoryGirl.create(:photo, 
        identifier: '4',
        thumbnail: "/assets/uploads/instagram/thumbnail/fernzzzaa/9f599bd6fbc911e1a44612313804e8c1_7.jpg",
        full: "/assets/uploads/instagram/full/fernzzzaa/9f599bd6fbc911e1a44612313804e8c1_6.jpg", 
        account: account
        )

      visit ("/")
      current_path.should == "/"
      page.should have_css("#grid" , :text => "Girl Grid")
      click_link ('Girl Grid')
      page.should have_css("img[@alt='9f599bd6fbc911e1a44612313804e8c1_7']")
    end
  end

  describe "Show photo when I clicked photo" do
      it "I want to click photo show a new tab" do
      user = FactoryGirl.create(:user, email: "artiwarah@example.com",user_type: "girl", nickname: "JOE")
      account = FactoryGirl.create(:account,username: "artiwarah", type: "FacebookAccount", user: user)
      photo = FactoryGirl.create(:photo, 
        identifier: '3',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg", 
        account: account
        )

      visit ("/")
      current_path.should == "/"
      page.should have_css("#grid" , :text => "Girl Grid")
      click_link ('Girl Grid')
      page.find("img[@alt='182869_3569852204790_1354565865_n']").click
    end
  end
end
