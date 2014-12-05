module Spree
  Admin::ProductsController.class_eval do
    skip_before_filter :load_resource, :only => [:edit_multiple, :update_multiple, :destroy_multiple, :display_brand_products]
    before_filter :load_multiple, :only => [:update_multiple, :destroy_multiple]
    before_filter :update_product_price, :only => :update_multiple


    def edit_multiple
      session[:im_per_page] = params[:per_page].to_i if !params[:per_page].nil?
      @taxon = params[:id].present? ? Taxon.find(params[:id]) : Taxon.root
      product_ids = @taxon.present? ? @taxon.product_ids.flatten.uniq : []

      params[:q] ||= {}
      params[:q][:deleted_at_null] = '1' if params[:q][:deleted_at_null].nil?
      params[:q][:s] ||= 'name asc'

      @search = Product.where(:id => product_ids).ransack(params[:q])
      @collection = @search.result.page(params[:page]).per(session[:im_per_page] || 10)
      
      respond_with(@collection) do |format|
        format.html
        format.json { render :json => json_data }
      end
    end
    
    def display_brand_products
      session[:im_per_page] = params[:per_page].to_i if !params[:per_page].nil?
      @taxon = Taxon.root

      params[:q] ||= {}
      params[:q][:deleted_at_null] = '1' if params[:q][:deleted_at_null].nil?
      params[:q][:s] ||= 'name asc'

      @search = Product.with_property_value("brand", params[:id]).ransack(params[:q])
      @collection = @search.result.page(params[:page]).per(session[:im_per_page] || 10)
      
      respond_with(@collection) do |format|
        format.html
        format.json { render :json => json_data }
      end
    end

    def update_multiple
      flash[:notice] = I18n.t('sim.products_successfully_updated')
      respond_with(@collection) do |format|
        format.html { redirect_to :back } #admin_edit_multiple_products_url(:id => params[:id]) }
        format.json { render :json => json_data }
      end
    end

    def destroy_multiple
      authorize! :destroy, Product
      @collection.each do |pr|
        pr.update_attributes!(:deleted_at => Time.zone.now)
        pr.variants.each { |v| v.update_attributes!(:deleted_at => Time.zone.now) }
      end
      flash[:notice] = I18n.t('sim.products_successfully_deleted')
      respond_with(@collection) do |format|
        format.html { redirect_to :back } #admin_edit_multiple_products_url(:id => params[:id]) }
        format.json { render :json => json_data }
      end
    end

    def load_multiple
      @collection = Product.where(:id => params[:product_ids])
    end
    
    def update_product_price
      if params[:product][:price_percentage].blank?
        @collection.each { |pr| pr.update_attributes!(permitted_resource_params) }
      else  
        @collection.each do |pr|
          pr.get_update_product_price(params[:product][:price_percentage])
        end  
      end
    end
    
    private :load_multiple

  end
end
