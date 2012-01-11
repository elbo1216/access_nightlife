module Admin
  class GalleryController < AdminController
    layout "admin_layout"
    before_filter :authorize_admin, :except => [:index, :create, :add_images, :edit_comment, :delete_image]

    def index
      sql = "select gm.* from galleries g left join gallery_images gm on g.id = gm.gallery_id where is_current_slideshow  = 1"
      @slideshow = GalleryImage.find(:all, :joins => :gallery, :conditions => 'is_current_slideshow  = 1')

      @galleries = Gallery.find_by_sql("select * from galleries g order by id desc limit 50")
    end

    def create
      sql = "select id, event_name from events order by 1 desc limit 50"
      @events = Event.find_by_sql(sql)
      @gallery = Gallery.new
      if request.post?
        if !params[:event_id].blank?
          if params[:event_id].to_i == 0
            flash[:notice] = "Event ID must be an number.  If you do not know the event ID please pick an event from Event Name drop down"
            return
          end

          if !params[:event].blank?
            flash[:notice] = "You can only enter in an Event ID or pick an Event Name.  Please remove one before submitting."
            return
          end
          event = Event.find(params[:event_id])
          unless event.blank?
            @gallery.event = event
          else 
            flash[:notice] = "Event does not exist.  Please enter an existing event id or choose an event from the drop down menu"
            return
          end
        elsif !params[:event].blank?
          @gallery.event_id = params[:event]
        else
          flash[:notice] = "A gallery needs an event.  Please enter an event id or choose an event from the drop down menu"
          return
        end
        logo = GalleryLogo.new
        logo.upload_image(params[:gallery_logo_image])
        logo.save!
        logo.reload

        @gallery.name = params[:gallery_name]
        @gallery.is_current_slideshow = params[:is_current_slideshow] || false
        @gallery.gallery_path = "#{RAILS_ROOT}/public/images/gallery"
        @gallery.gallery_logo_id = logo.id
        @gallery.description_short = params[:description_short]
        @gallery.description_long = params[:description_long]
        @gallery.save!
        redirect_to :action => 'index'
      end
    end

    def edit
      @gallery = Gallery.find(params[:id])
      @slideshow = GalleryImage.find(:all, :conditions => "gallery_id = #{params[:id]}")
      @events = Event.find_by_sql("select id, event_name from events order by 1 desc limit 50")
      if request.post?
        if !params[:event_id].blank?
          event = Event.find(params[:event_id])
          unless event.blank?
            @gallery.event = event
          else 
            flash[:notice] = "Event does not exist.  Please enter an existing event id or choose an event from the drop down menu"
            return
          end
        elsif params[:event]
          @gallery.event_id = params[:event]
        else
          flash[:notice] = "A gallery needs an event.  Please enter an event id or choose an event from the drop down menu"
          return
        end

        unless params[:gallery_logo_image].blank?
          logo = GalleryLogo.new
          logo.upload_image(params[:gallery_logo_image])
          logo.save!
          logo.reload
          @gallery.gallery_logo_id = logo.id
        end

        @gallery.name = params[:gallery_name]
        @gallery.is_current_slideshow = params[:is_current_slideshow]
        @gallery.description_short = params[:description_short]
        @gallery.description_long = params[:description_long]
        @gallery.gallery_path = "#{RAILS_ROOT}/public/images/gallery"
        @gallery.save!
      end
    end

    def make_live
      Gallery.find(params[:id]).make_live
      redirect_to :action => 'index'
    end

    def make_feature
      Gallery.find_by_sql("select * from galleries where is_feature_gallery is true").each do |g|
        g.is_feature_gallery = false
        g.save!
      end
      Gallery.find(params[:id]).make_feature
      redirect_to :action => 'index'
    end

    def remove_live
      Gallery.find(params[:id]).remove_live
      redirect_to :action => 'index'
    end

    def remove_feature
      Gallery.find(params[:id]).remove_feature
      redirect_to :action => 'index'
    end

    def edit_comment
      gi = GalleryImage.find(params[:id])
      gi.edit_comments(params[:comment])
      gi.reload
      render :text => gi.image_comments
    end

    def add_images
      if request.post?
        params.each_key do |k|
          if k.starts_with?("gallery_image")
            upload_file(params[k], params[:id]) unless params[k].blank?
          end
        end
        redirect_to :action => params[:load_page], :id => params[:id]
      end
    end

    def upload_file(file, gallery_id)
      gi = GalleryImage.create!(:gallery_id => gallery_id) 
      gi.upload_image(file)
    end

    def delete
      id = params[:id]
      gi = GalleryImage.find(:all, :joins => "join galleries", :conditions => "galleries.id = #{id}")
      gi.each do |i|
        i.destroy
      end
      g = Gallery.find(id)
      g.destroy
      redirect_to :action => 'index'
    end

   def delete_image
     id = params[:id]
     gi = GalleryImage.find(id)
     gallery = gi.gallery
     gi.destroy
     redirect_to :action => params['load_page'], :id => gallery.id
   end

    def add_gallery_to_slideshow
      g = Gallery.find(params[:id])
      g.add_to_slideshow
      redirect_to :action => 'index'
    end

    def remove_gallery_from_slideshow
      g = Gallery.find(params[:id])
      g.remove_from_slideshow
      redirect_to :action => 'index'
    end

    def add_image_to_slideshow
      gi = GalleryImage.find(params[:id])
      gi.is_slideshow_image = 1
      gi.save!
      render :nothing => true
    end

    def remove_image_from_slideshow
      gi = GalleryImage.find(params[:id])
      gi.is_slideshow_image = 0
      gi.save!
      render :nothing => true
    end

    def set_as_main_image
      gi = GalleryImage.find(params[:id])
      old_gi = GalleryImage.find_by_sql("select * from gallery_images where gallery_id = #{gi.id} and is_media_image is true")
      old_gi.each do |og|
        og.is_media_image = 0
        og.save!
      end
      gi.is_media_image = 1
      gi.save!
      redirect_to :action => 'index'
    end
  end
end
