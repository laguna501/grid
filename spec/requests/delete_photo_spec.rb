# encoding: UTF-8
require 'request_spec_helper'

describe "Delete and Undelete photos", js: true do
  describe "Delete Photos" do
    it "As an admin I want to delete photos for not show photo in grid page" do
      admin = FactoryGirl.create(:admin, username: "test", password: "000000",password_confirmation: "000000")
      user = FactoryGirl.create(:user, email: "artiwarah@example.com",user_type: "pro", nickname: "JOE")
      account = FactoryGirl.create(:account,username: "artiwarah", type: "FacebookAccount", user: user)
      photo = FactoryGirl.create(:photo,
        identifier: '1',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg",
        account: account
        )

      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      page.should have_css(".frame", :text => "Login successful.")
      check('select[]')
      click_button ('Delete Photos')
      page.should have_css(".frame", :text => "Update photos successfully")
      page.should have_css(".detail", :text => "Deleted")
    end

    it "As an admin I want to delete all photos for not show photo in grid page" do
      admin = FactoryGirl.create(:admin, username: "test", password: "000000",password_confirmation: "000000")
      user = FactoryGirl.create(:user, email: "artiwarah@example.com",user_type: "pro", nickname: "JOE")
      account = FactoryGirl.create(:account,username: "artiwarah", type: "FacebookAccount", user: user)
      photo = FactoryGirl.create(:photo,
        identifier: '1',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg",
        account: account
        )
      FactoryGirl.create(:photo,
        identifier: '2',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg",
        account: account
        )
      FactoryGirl.create(:photo,
        identifier: '3',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg",
        account: account
        )

      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      page.should have_css(".frame", :text => "Login successful.")
      click_button ('Select All')
      click_button ('Delete Photos')
      page.should have_css(".frame", :text => "Update photos successfully")
      page.should have_css(".detail", :text => "Deleted")
    end
  end

  describe "Undelete Photos" do
    it "As an admin I want to undelete photos for not show photo in grid page" do
      admin = FactoryGirl.create(:admin, username: "test", password: "000000",password_confirmation: "000000")
      user = FactoryGirl.create(:user, email: "artiwarah@example.com",user_type: "pro", nickname: "JOE")
      account = FactoryGirl.create(:account,username: "artiwarah", type: "FacebookAccount", user: user)
      photo = FactoryGirl.create(:photo,
        identifier: '1',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg",
        deleted: true,
        account: account
        )

      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      page.should have_css(".frame", :text => "Login successful.")
      check('select[]')
      click_button ('Undelete Photos')
      page.should have_css(".frame", :text => "Update photos successfully")
      page.should have_no_css(".detail", :text => "Deleted")
    end

    it "As an admin I want to undelete all photos for not show photo in grid page" do
      admin = FactoryGirl.create(:admin, username: "test", password: "000000",password_confirmation: "000000")
      user = FactoryGirl.create(:user, email: "artiwarah@example.com",user_type: "pro", nickname: "JOE")
      account = FactoryGirl.create(:account,username: "artiwarah", type: "FacebookAccount", user: user)
      photo = FactoryGirl.create(:photo,
        identifier: '1',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg",
        deleted: true,
        account: account
        )
      FactoryGirl.create(:photo,
        identifier: '2',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg",
        deleted: true,
        account: account
        )
      FactoryGirl.create(:photo,
        identifier: '3',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg",
        deleted: true,
        account: account
        )

      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      page.should have_css(".frame", :text => "Login successful.")
      click_button ('Select All')
      click_button ('Undelete Photos')
      page.should have_css(".frame", :text => "Update photos successfully")
      page.should have_no_css(".detail", :text => "Deleted")
    end
  end
end
