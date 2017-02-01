class ApplicationPDF < Prawn::Document
  include ActionView::Helpers::NumberHelper

  def initialize(opts={})
    opts.reverse_merge!(
      page_layout: :portrait
    )
    super(opts)
    font('Helvetica')
  end

  def filename
    self.class.to_s.titleize.gsub(/(PDF|Document)$/, '').chop
  end
end
