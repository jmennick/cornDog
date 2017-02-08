class ApplicationPDF < Prawn::Document
  include ActionView::Helpers::NumberHelper

  def initialize(opts={})
    opts.reverse_merge!(
      page_layout: :portrait
    )
    super(opts)
    # font('Helvetica')
    font(self.class.default_font_name,
      size: self.class.default_font_size
    )
  end

  def filename
    self.class.to_s.titleize.gsub(/(PDF|Document)$/, '').chop
  end

  def self.default_font_name
    'Courier'
  end

  def self.default_font_size
    8
  end
end
