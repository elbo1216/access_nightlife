  class LoginController < ApplicationController
    def index
      if request.post?
        @user_session = UserSession.new(:email=> params[:login], :password => params['password'], :remember_me => true)
        if error = @user_session.save
          redirect_to '/admin/event/index'
        end
        flash[:notice] = 'Username/password incorrect'
      end
    end

  end
