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
      self.price = set_last_digit(self.price)
      self.save
    end
    
    def set_last_digit(price)
      price=price.to_f.round(2)
      ld = price.to_s.last.to_i
      if ld==0
        return price
      elsif ld < 4  
        return price - (".0" + (ld+1).to_s).to_f 
      else
        return price + (".0" + (9-ld).to_s).to_f
      end

    end
    
  end
end
