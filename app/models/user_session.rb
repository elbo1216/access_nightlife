class UserSession < Authlogic::Session::Base
#  logout_on_timeout true
  find_by_login_method :find_by_is_admin_user_and_email
  verify_password_method :verify_password?
end
