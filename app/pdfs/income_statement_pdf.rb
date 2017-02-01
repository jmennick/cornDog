class IncomeStatementPDF < ApplicationPDF
  def initialize()
    super()

    text('Income Statement', align: :center, style: :bold, size: 16)

    revenues = [
      {name: 'Service Revenue', credit: 108_000}
    ]

    total_revenues = revenues.reduce(0.0) do |acc, r|
      acc + r.fetch(:credit, 0.0) - r.fetch(:debit, 0.0)
    end

    expenses = [
      {name: 'Utilities', debit: 5_800},
      {name: 'Supplies', debit: 4_000},
      {name: 'Salary', debit: 29_000},
      {name: 'Property Tax', debit: 1_200}
    ]

    total_expenses = expenses.reduce(0.0) do |acc, e|
      acc + e.fetch(:credit, 0.0) - e.fetch(:debit, 0.0)
    end

    net_income = total_revenues + total_expenses

    data = [
      [
        {content: '', borders: []},
        {content: '$', align: :center, borders: []},
        {content: '$', align: :center, borders: []}
      ],
      [
        {content: '', borders: []},
        {content: 'Debit', align: :center, borders: []},
        {content: 'Credit', align: :center, borders: []}
      ],
      [{content: 'Revenues:', colspan: 3, borders: []}],
      *revenues.map{|r|
        [
          {content: r[:name], padding: [5, 5, 5, 20], borders: []},
          {content: number_to_accounting(r[:debit]), borders: []},
          {content: number_to_accounting(r[:credit]), borders: []}
        ]
      },
      [{content: 'Expenses:', colspan: 3, borders: []}],
      *expenses.map{|e|
        [
          {content: e[:name], padding: [5, 5, 5, 20], borders: []},
          {content: number_to_accounting(e[:debit]), borders: []},
          {content: number_to_accounting(e[:credit]), borders: []}
        ]
      },
      [
        {
          content: 'Total Expenses',
          padding: [5, 5, 5, 40],
          colspan: 2,
          borders: []
        },
        {
          content: number_to_accounting(total_expenses),
          borders: [:bottom, :top]
        }
      ],
      [
        {content: 'Net Income', colspan: 2, borders: []},
        {content: number_to_accounting(net_income), borders: []}
      ]
    ]
    table(data) do
    end
  end

  def number_to_accounting(number)
    return '' if number.nil?
    number_to_currency(number,
      precision: 2,
      unit: '',
      negative_format: '(%u%n)'
    )
  end
end
