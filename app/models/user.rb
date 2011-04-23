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

  def valid_password?(pass)
    pass == decrypt(self.crypted_password)
  end

  def is_root?
    root = Group.find(:first, :conditions => "group_key = 'root'")
    self.user_groups.select {|ug| ug.group_id}.include?(root.id)
  end

  private

  def decrypt(encrypted_password)
    encrypted_password
  end

end
