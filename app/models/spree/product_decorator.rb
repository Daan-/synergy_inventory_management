module Spree
  Product.class_eval do
    attr_accessor :add_taxon
    after_save :add_taxon_save
    
    def active?
      self.deleted_at.nil? and available?
    end

    def available?
      available_on.nil? ? false : available_on < Time.zone.now
    end

    def add_taxon_save
      return true unless add_taxon.present?
      taxon = Taxon.find(add_taxon)
      product_taxons = self.taxons
      
      if product_taxons.present?
        product_taxons.each do |prod_taxon|
          product_taxons.delete(prod_taxon)
        end      
      end
          
      product_taxons << taxon if !product_taxons.include? taxon
      true
    end
    
    def get_update_product_price(price_percentage)
      self.retail_amount = self.price unless self.retail_amount.to_f > 0.0
      self.price = (self.retail_amount.to_f - ((self.retail_amount.to_f*price_percentage.to_i)/100))
      self.save
    end
    
  end
end
