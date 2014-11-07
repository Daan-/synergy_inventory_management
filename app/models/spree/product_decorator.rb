module Spree
  Product.class_eval do
    #attr_accessible :add_taxon
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
  end
end
