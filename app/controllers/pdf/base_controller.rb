class PDF::BaseController < ApplicationController::API
  def send_pdf(pdf_or_class, filename: nil)
      pdf = case pdf_or_class
      when Class then pdf_or_class.new
      else pdf_or_class
      end

      send_data pdf.render,
        filename: filename || pdf.filename,
        type: 'application/pdf',
        disposition: 'inline'
  end
end
