class PDF::TestController < PDF::BaseController
  def test
    send_pdf(IncomeStatementPDF)
  end
end
