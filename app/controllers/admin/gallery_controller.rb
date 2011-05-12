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
        @gallery.name = params[:gallery_name]
        @gallery.is_current_slideshow = params[:is_current_slideshow]
        @gallery.gallery_path = "#{RAILS_ROOT}/public/images/gallery"
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
        @gallery.name = params[:gallery_name]
        @gallery.is_current_slideshow = params[:is_current_slideshow]
        @gallery.gallery_path = "#{RAILS_ROOT}/public/images/gallery"
        @gallery.save!
      end
    end

    def edit_comment
      gi = GalleryImage.find(params[:id])
      gi.image_comments = params[:comment]
      gi.save!
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
  end
end
