module Admin
  class MainController < AdminController
    layout "admin_layout"

    def index
      if request.post?
        if params['commit'] == 'Add Social Media'
          SocialMediaAccount.create!(:media_name => params['media_name'], :media_url => params['add_media_url'])
        end
      end
      @medias = SocialMediaAccount.all
      @music_list = MusicFile.all
    end

    def delete_social_media
      @media = SocialMediaAccount.find(params['id'])
      @media.destroy
      redirect_to :action => 'index'
    end

    def edit_url
      @media = SocialMediaAccount.find(params['id'])
      @media.media_url = params['url']
      @media.save!
      render :text => @media.media_url
    end

    def upload_music
      if params['commit'] == 'Add Music'
        mf = MusicFile.new
        mf.upload_music_file(params['music'], params['music']['file'].original_filename)
        mf.save!
        redirect_to :action => 'index'
      end
    end

    def delete_music_file
      mf = MusicFile.find(params['id'])
      mf.delete_file
      redirect_to :action => 'index'
    end

    def set_music_file_active
      mf = MusicFile.find(params['id'])
      mf.set_music_file_active!
      redirect_to :action => 'index'
    end
  end
end
