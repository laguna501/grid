class UserSession < Authlogic::Session::Base
	authenticate_with Admin
	# allow_http_basic_auth false
end
