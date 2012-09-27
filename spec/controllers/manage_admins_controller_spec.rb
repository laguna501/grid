require 'spec_helper'
describe ManageAdminsController do

  describe "index" do
    it "get index" do
    	login_as do |admin, user_session|
    		get :index

	    	response.should be_success
	    	response.should render_template("index")
    	end    	
    end
  end

  describe "new" do
    it "get new page" do
    	login_as do |admin, user_session|
	    	get :new

	    	response.should be_success
	    	response.should render_template("new")
	    end
    end
  end

  describe "create" do
    it "create page" do
    	login_as do |admin, user_session|
	    	post :create, admin: {
	    		username: "Admin",
	    		password: "111111",
	    		password_confirmation: "111111"
	    	}

	    	response.should redirect_to(manage_admins_url)
	      flash[:notice].should == "Admin successfully created."
      end
    end
  end

  describe "destroy" do
    it "deletes admin" do
      admin_1 = FactoryGirl.create(:admin)

      login_as do |admin, user_session|
        delete :destroy, id: admin_1.id

        response.should redirect_to(manage_admins_url)
        flash[:notice].should == "Admin successfully destroyed."
      end
    end
  end

  describe "update" do
  	it "current_user can update and validate original_password" do  		
  		admin_1 = FactoryGirl.create(:admin) 
  		login_as do |admin, user_session|
  			put :update, id: admin_1.id, admin: {
  				username: "Admin",
  				password: "222222",
  				password_confirmation: "222222"
  			}

  			response.should redirect_to(manage_admins_url)
  			flash[:notice].should == "Admin successfully updated."
  		end
  	end
  end	
end