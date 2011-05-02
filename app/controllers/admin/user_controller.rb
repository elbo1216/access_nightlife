module Admin
  class UserController < AdminController
    before_filter :authorize_root

    def index
      @users = []
      if request.post?
        conditions = "1 = 1"
        conditions << " and firstname like '%#{params['firstname']}%'" unless params['firstname'].blank?
        conditions << " and lastname like '%#{params['lastname']}%'" unless params['lastname'].blank?
        conditions << " and email = '#{params['email']}'" unless params['email'].blank?
        @users = User.find(:all, :conditions => conditions)
      end
    end

    def create
      @user = User.new
      @groups = Group.all
      @gm=[]
      if request.post?
        @user = User.create!(params['user'])
        if params['groups']
          params['groups'].each do |g|
            UserGroup.create!(:user_id => @user.id, :group_id => g)
          end
        end
        flash[:notice] = "Create successful."
        redirect_to :action => 'index'
      end
    end
    
    def edit
      @user = User.find(params['id'])
      @groups = Group.all
      @gm = UserGroup.find(:all, :conditions => "user_id = #{@user.id}").map {|ug| ug.group_id }
      if request.post?
        @user.update_attributes(params['user'])
        # Check is_admin_user flag to make sure if it was unset. If so we need to do this manually
        @user.update_attributes({'is_admin_user' => false}) if params['user']['is_admin_user'].blank?
        if params['groups']
          params['groups'].each do |g|
            if @gm.include?(g.to_i)
              @gm.delete(g.to_i)
            else
              UserGroup.create!(:user_id => @user.id, :group_id => g)
              @gm.delete(g.to_i)
            end
          end
        end
        @gm.each do |g|
          ug = UserGroup.find(:all, :conditions => "user_id = #{@user.id} and group_id = #{g}")
          UserGroup.destroy(ug.first.id) if ug
        end
        flash[:notice] = "Update successful."
        redirect_to :action => 'index'
        return
      end
      render :action => "create"
    end

    def delete
      user = User.find(params['id'])
      User.destroy(user.id)
      ug = UserGroup.find(:all, :conditions => "user_id = #{params['id']}")
      ug.each { |u| UserGroup.destroy(u.id) }
    end
  
  end
end
