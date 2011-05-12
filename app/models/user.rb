class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_login_field = false
    c.validate_email_field = false
    c.validate_password_field = false
   # c.logged_in_timeout = 10.minutes
  end

	 has_many :event_requests
  has_many :user_groups

  def User.find_by_is_admin_user_and_email(login)
    User.find(:first, :conditions => "is_admin_user = 1 and email = '#{login}'")
  end

  def is_root?
    root = Group.find(:first, :conditions => "group_key = 'root'")
    self.user_groups.map {|ug| ug.group_id}.include?(root.id)
  end

  def verify_password?(params)
    valid_password?(params).inspect
  end

  def photographer_only?
    !self.user_groups.blank? && self.user_groups.size == 1 && self.user_groups.first.group.group_key == 'photographer'
  end
end
