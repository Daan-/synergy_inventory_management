Spree::BaseHelper.module_eval do

  def display_price(product_or_variant)
    product_or_variant.price_in(Spree::Config[:currency]).display_price.to_html
  end
  
  def display_reatil_amount(product_or_variant)
    product_or_variant.price_in(Spree::Config[:currency]).display_retail_price.to_html
  end
  
end
