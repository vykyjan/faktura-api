module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Faktura-api"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def number_to_currency(number, options = {})
    options[:locale] ||= I18n.locale
    super(number, options)
  end
end
