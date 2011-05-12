module Admin
  class AffiliateController < AdminController
    def index
      @affiliates = Affiliate.all
    end

    def create
      aff = Affiliate.new
      aff.affiliate_name = params['name']
      aff.upload_affiliate_image(params['affiliate'], params['affiliate']['image'].original_filename)
      aff.save!
      redirect_to :action => 'index'
    end

    def delete
      aff = Affiliate.find(params['id'])
      aff.delete_file
      redirect_to :action => 'index'
    end

    def set_active
      aff = Affiliate.find(params['id'])
      aff.set_active!
      redirect_to :action => 'index'
    end

    def set_inactive
      aff = Affiliate.find(params['id'])
      aff.set_inactive!
      redirect_to :action => 'index'
    end
  end
end
