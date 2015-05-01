require 'extensions/page'

activate :page_title
activate :automatic_image_sizes
activate :directory_indexes
activate :livereload

activate :s3_sync do |s3_sync|
  s3_sync.bucket = 'bioboxes.org'
  s3_sync.region = 'us-west-1'
  s3_sync.acl    = 'public-read'
end

set :css_dir,      'stylesheets'
set :js_dir,       'javascripts'
set :images_dir,   'images'
set :partials_dir, 'partials'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

# silence i18n warning
::I18n.config.enforce_available_locales = false

page "*", :layout => "layouts/default"
page "/", :layout => "layouts/front-page"
page "/guide/*", :layout => "layouts/guides"
