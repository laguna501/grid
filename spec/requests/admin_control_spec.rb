# encoding: UTF-8
require 'request_spec_helper'

describe "Test admin access control", js: true do
  describe "Login page" do
  	before(:each) do
  		admin = FactoryGirl.create(:admin, username: "TESTACCESSCONTROL", 
  			password: "000000", 
  			password_confirmation: "000000")
  	end

    it "As an admin I want to login page" do
      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
      	fill_in 'user_session[username]', :with => 'TESTACCESSCONTROL'
      	fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      page.should have_css(".frame", :text => "Login successful.")
      page.should have_css("#wrap", :text => "Photo Management")
      page.should have_css(".menu-admin", :text => "Gride" , :text => "Photo" , :text => "Manage", :text => "LOGOUT" , :text => "(TESTACCESSCONTROL)" )  
      current_path.should == "/photos"
    end

 	  it "As an admin I want to login page failed" do
      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
      	fill_in 'user_session[username]', :with => 'TESTACCESSCONTROL'
      	fill_in 'user_session[password]', :with => '000'
        click_button ('Login')
      end
      page.should have_css(".frame", :text => "Login fail")
      current_path.should == "/user_session/new"
    end 

    it "As an admin I want to lotout system" do
      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'TESTACCESSCONTROL'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      page.should have_css(".frame", :text => "Login successful.")
      click_link ('LOGOUT')
      find_button ('Login')
      current_path.should == "/user_session/new"
    end
  end

  describe "Manage account" do
    before(:each) do
      admin = FactoryGirl.create(:admin, username: "Test", 
        password: "000000", 
        password_confirmation: "000000")
    end

    it "As an admin want to see user in management user page" do
      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'Test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      page.should have_css(".frame", :text => "Login successful.")
      page.should have_css(".menu-admin", :text => "Manage")
      click_link ('Manage')
      page.should have_css("#wrap", :text => "Management")
      page.should have_css("#wrap", :text => "Test")
      current_path.should == "/manage_admins"
    end

    it "As an admin want to see create admin page" do
      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'Test'
        fill_in 'user_session[password]', :with => '000000' 
        click_button ('Login')
      end
      page.should have_css(".frame", :text => "Login successful.")
      page.should have_css(".menu-admin", :text => "Manage")
      click_link ('Manage')
      page.should have_css("#wrap", :text => "Management")
      click_link ('Create Admin')
      page.should have_css('.frame', :text => 'Create Admin')
      current_path.should == "/manage_admins/new"
    end

    it "As an admin want to create admin" do
      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'Test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      visit ("/manage_admins/new")
      within ("#new_admin") do
        fill_in 'admin[username]', :with => 'Test01'
        fill_in 'admin[password]', :with => 'Test01'
        fill_in 'admin[password_confirmation]', :with => 'Test01'
        click_button ('Create')
      end
      page.should have_css(".frame", :text => "Admin successfully created.")
      page.should have_css("#wrap", :text => "Test01")
      current_path.should == "/manage_admins"  
    end

    it "As an admin want to create admin but don't fill in information in field" do
      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'Test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      visit ("/manage_admins/new")
      click_button ('Create')
      page.should have_css("#wrap", :text => "Username is too short (minimum is 3 characters)")
    end

    it "As an admin I want to create admin and fill in duplicate username in the system)" do
      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'Test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      visit ("/manage_admins/new")
       within ("#new_admin") do
        fill_in 'admin[username]', :with => 'Test'
        fill_in 'admin[password]', :with => 'Test01'
        fill_in 'admin[password_confirmation]', :with => 'Test01'
        click_button ('Create')
      end
      page.should have_css("#wrap", :text => "Username has already been taken")
    end

    it "As an admin I want to edit my information" do
      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'Test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      visit ("/manage_admins")
      click_link('Edit')
      page.should have_css(".frame", :text => "Edit Information")
      within ("#edit_admin_1") do
        fill_in 'admin[original_password]', :with => '000000'
        fill_in 'admin[password]', :with => '111111'
        fill_in 'admin[password_confirmation]', :with => '111111'
        click_button ('Update information')
      end
      page.should have_css("#wrap")
      current_path.should == "/user_session/new"
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'Test'
        fill_in 'user_session[password]', :with => '111111'
        click_button ('Login')
      end
      page.should have_css(".menu-admin", :text => "(Test" )  
      current_path.should == "/photos"
    end

    it "As an admin I want to edit user" do
      user =  FactoryGirl.create(:admin, username: "Testing", 
        password: "000000", 
        password_confirmation: "000000")

      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'Test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      visit ("/manage_admins/2/edit")
      page.should have_css(".frame", :text => "Edit Information")
      within ("#edit_admin_2") do
        fill_in 'admin[password]', :with => '111111'
        fill_in 'admin[password_confirmation]', :with => '111111'
        click_button ('Update information')
      end
      page.should have_css(".frame", :text => "Admin successfully updated.")
    end

     it "As an admin I want to edit my information but forgot fill in the field" do
       user =  FactoryGirl.create(:admin, username: "Testing", 
        password: "000000", 
        password_confirmation: "000000")

      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'Test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      visit ("/manage_admins/2/edit")
      page.should have_css(".frame", :text => "Edit Information")
      within ("#edit_admin_2") do
        fill_in 'admin[username]', :with => ''
        click_button ('Update information')
      end
      page.should have_css(".frame", :text => "Username is too short")
    end

    it "Admin want to edit password I have incorrect original password, new password,and new password confirmation" do
       user =  FactoryGirl.create(:admin, username: "Testing", 
        password: "000000", 
        password_confirmation: "000000")

      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'Test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      visit ("/manage_admins/1/edit")
      page.should have_css(".frame", :text => "Edit Information")
      within ("#edit_admin_1") do
        fill_in 'admin[original_password]', :with => '111111'
        fill_in 'admin[password]', :with => '111111'
        fill_in 'admin[password_confirmation]', :with => '118111'
        click_button ('Update information')
      end
      page.should have_css(".frame", :text => "Password doesn't match confirmation, Original password is wrong")
    end
  end
end