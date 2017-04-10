class TimeValueFormatter < JSONAPI::ValueFormatter
  FORMAT='%m/%d/%Y %I:%M:%S%p'

  class << self
    def format(raw_value)
      super(raw_value.to_time.strftime(FORMAT))
    end

    def unformat(value)
      # super(Date.strptime(value, FORMAT))
      super(Time.parse(value))
    end
  end
end
