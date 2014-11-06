# -*- encoding: utf-8 -*-
# stub: synergy_inventory_management 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "synergy_inventory_management"
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Sergey Chazov (Service & Consulting)"]
  s.date = "2014-11-06"
  s.description = "Manage inventory"
  s.email = "service@secoint.ru"
  s.files = [".gitignore", "Gemfile", "README.md", "Rakefile", "Versionfile", "app/assets/images/admin/icons/camera.png", "app/assets/stylesheets/admin/synergy_imi.css", "app/controllers/spree/admin/products_controller_decorator.rb", "app/models/spree/product_decorator.rb", "app/models/spree/taxon_decorator.rb", "app/overrides/sim_admin_product_sub_tabs.rb", "app/overrides/sim_new_product_taxon_field.rb", "app/views/spree/admin/products/_js_head.erb", "app/views/spree/admin/products/_taxon.erb", "app/views/spree/admin/products/edit_multiple.html.erb", "app/views/spree/admin/products/update.js.erb", "config/locales/en.yml", "config/locales/ru.yml", "config/routes.rb", "lib/generators/synergy_inventory_management/install/install_generator.rb", "lib/synergy_inventory_management.rb", "synergy_inventory_management.gemspec"]
  s.homepage = "https://github.com/secoint/synergy_inventory_management"
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = "synergy_inventory_management"
  s.rubygems_version = "2.2.2"
  s.summary = "Manage inventory"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<spree_core>, [">= 1.3.0"])
    else
      s.add_dependency(%q<spree_core>, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<spree_core>, [">= 1.3.0"])
  end
end
