class UserSession < Authlogic::Session::Base
	authenticate_with Admin
end
