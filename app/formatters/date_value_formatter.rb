class DateValueFormatter < JSONAPI::ValueFormatter
  FORMAT='%m/%d/%Y'

  class << self
    def format(raw_value)
      super(raw_value.to_date.strftime(FORMAT))
    end

    def unformat(value)
      super(value.strptime(value, FORMAT))
    end
  end
end
