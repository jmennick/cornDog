# class IncomeStatementPDF < ApplicationPDF
class IncomeStatementPDF < TabularReportPDF
  # title 'Hello World!'

  section 'X'
  two_column 'Blah blah', credit: 42.0
  two_column 'Blah blah', credit: 42.0

  section 'Y'
  two_column 'Blah blah', debit: 42.0

  # def initialize()
  #   super()
  #
  #   text('Income Statement', align: :center, style: :bold, size: 16)
  #
  #   revenues = [
  #     {name: 'Service Revenue', credit: 108_000}
  #   ]
  #
  #   total_revenues = revenues.reduce(0.0) do |acc, r|
  #     acc + r.fetch(:credit, 0.0) - r.fetch(:debit, 0.0)
  #   end
  #
  #   expenses = [
  #     {name: 'Utilities', debit: 5_800},
  #     {name: 'Supplies', debit: 4_000},
  #     {name: 'Salary', debit: 29_000},
  #     {name: 'Property Tax', debit: 1_200}
  #   ]
  #
  #   total_expenses = expenses.reduce(0.0) do |acc, e|
  #     acc + e.fetch(:credit, 0.0) - e.fetch(:debit, 0.0)
  #   end
  #
  #   net_income = total_revenues + total_expenses
  #
  #   data = [
  #     [
  #       {content: '', borders: []},
  #       {content: '$', align: :center, borders: []},
  #       {content: '$', align: :center, borders: []}
  #     ],
  #     [
  #       {content: '', borders: []},
  #       {content: 'Debit', align: :center, borders: []},
  #       {content: 'Credit', align: :center, borders: []}
  #     ],
  #     [{content: 'Revenues:', colspan: 3, borders: []}],
  #     *revenues.map{|r|
  #       [
  #         {
  #           content: r[:name],
  #           padding: [5, 5, 5, 20], borders: []
  #         },
  #         {
  #           content: number_to_accounting(r[:debit]),
  #           align: :right, borders: []
  #         },
  #         {
  #           content: number_to_accounting(r[:credit]),
  #           align: :right, borders: []
  #         }
  #       ]
  #     },
  #     [{content: 'Expenses:', colspan: 3, borders: []}],
  #     *expenses.map{|e|
  #       [
  #         {content: e[:name], padding: [5, 5, 5, 20], borders: []},
  #         {
  #           content: number_to_accounting(e[:debit]),
  #           align: :right, borders: []
  #         },
  #         {
  #           content: number_to_accounting(e[:credit]),
  #           align: :right, borders: []
  #         }
  #       ]
  #     },
  #     [
  #       {
  #         content: 'Total Expenses',
  #         padding: [5, 5, 5, 40],
  #         colspan: 2,
  #         borders: []
  #       },
  #       {
  #         content: number_to_accounting(total_expenses),
  #         borders: [:bottom, :top],
  #         padding: [5, total_expenses.negative? ? 2 : 5, 5, 5],
  #         align: :right
  #       }
  #     ],
  #     [
  #       {
  #         content: 'Net Income',
  #         colspan: 2, borders: []
  #       },
  #       {content:
  #         number_to_accounting(net_income),
  #         borders: [], align: :right
  #       }
  #     ]
  #   ]
  #   table(data) do
  #   end
  # end

  # def number_to_accounting(number)
  #   return '' if number.nil?
  #   number_to_currency(number,
  #     precision: 2,
  #     unit: '',
  #     negative_format: '(%u%n)'
  #   )
  # end
end
