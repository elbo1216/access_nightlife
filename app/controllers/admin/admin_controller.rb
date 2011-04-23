class Admin::AdminController < ApplicationController
	layout 'admin_layout'
 before_filter :require_user
 before_filter :authorize_admin


end
