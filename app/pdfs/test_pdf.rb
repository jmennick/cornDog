class TestPDF < ApplicationPDF
  def initialize()
    super()
    text "this is a TestPDF (titled #{filename})"
    text 'blah'
  end
end
