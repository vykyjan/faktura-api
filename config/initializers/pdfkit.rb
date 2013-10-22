PDFKit.configure do |config|
  config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf' if Rails.env.production?

config.default_options = {
      :page_size => 'Legal',
      :print_media_type => true,
      :encoding => "UTF-8",
      :disable_smart_shrinking => false


  }
  config.root_url = "http://localhost"
end