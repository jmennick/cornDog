class PDF::ChartOfAccountsController < PDF::BaseController
  def chart_of_accounts
    accounts = Account.all
    pdf = ChartOfAccountsPDF.new(accounts)
    send_pdf(pdf)
  end
end
