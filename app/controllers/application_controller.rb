# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
 # protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password

  helper_method :current_user
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user && !current_user_session.stale?
      flash[:notice] = "You must be logged in to access this page"
      redirect_to '/login'
      return false
    end
  end

  def authorize_promoter
   if current_user.is_admin_user && !current_user.is_root?
     ug = UserGroup.find(:all, :joins => 'join groups on groups.id=user_groups.group_id', :conditions => "user_id = #{current_user.id} and group_key = 'promoter'")
     redirect_to '/access_denied' if ug.blank?
   end
  end

  def authorize_admin
    redirect_to '/access_denied' unless current_user.is_admin_user
  end

 def authorize_root
   current_user.is_root?
 end

  def user_groups
    current_user.user_groups.map {|ug| ug.group_id }
  end
end
