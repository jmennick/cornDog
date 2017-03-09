class DateValueFormatter < JSONAPI::ValueFormatter
  FORMAT='%m/%d/%Y'

  class << self
    def format(raw_value)
      super(raw_value.to_date.strftime(FORMAT))
    end

    def unformat(value)
      # super(Date.strptime(value, FORMAT))
      super(Date.parse(value))
    end
  end
end
