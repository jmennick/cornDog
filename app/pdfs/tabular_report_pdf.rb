class TabularReportPDF < ApplicationPDF
  @@title = nil; @@rows = []

  def initialize
    super

    # Print title
    font(self.class.default_font_name, **self.class.title_font_opts) do
      text(title)
    end

    # Print date generated
    _date = Date.today.strftime('%m/%d/%y')
    _creator = "Gavin Smith"
    text("Generated #{_date} by #{_creator}")

    move_down 10

    # Print table of data
    if @@rows.any?
      table(@@rows.map do |r|
        case r[:_type]
        when :section
          [{
            content: "#{r[:name]}:",
            colspan: 3,
            padding: [*[default_padding]*2, row_padding, default_padding],
            borders: []
          }]
        when :two_column
          [
            {
              content: r[:name],
              padding: [row_padding, indention_padding]*2,
              borders: []
            },
            {
              content: number_to_accounting(r[:debit]),
              padding: [row_padding, default_padding]*2,
              align: :right,
              borders: []
            },
            {
              content: number_to_accounting(r[:credit]),
              padding: [row_padding, default_padding]*2,
              align: :right,
              borders: []
            }
          ]
        else
          []
        end
      end)
    else
      text '-- ERROR: NO CONTENT --'
    end
  end

  protected

  def self.title(val)
    @@title = val
  end

  def self.section(name)
    @@rows.push({
      _type: :section,
      name: name
    })
  end

  def self.two_column(name, credit: nil, debit: nil)
    @@rows.push({
      _type: :two_column,
      name: name,
      credit: credit,
      debit: debit
    })
  end

  def self.title_font_opts
    {
      size: default_font_size * 1.5,
      style: :bold
    }
  end

  private

  def title
    @@title || filename
  end

  def number_to_accounting(number)
    return '' if number.nil?
    number_to_currency(number,
      precision: 2,
      unit: '',
      negative_format: '(%u%n)'
    )
  end

  def default_padding
    5
  end

  def indention_padding(val = 1)
    default_padding + (15 * val)
  end

  def row_padding
    0
  end
end
