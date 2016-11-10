module ApiResponse
  class Base
    attr_accessor :data, :field

    def initialize(data, field)
      raise ArgumentError.new("data params should not be nil") unless data
      raise ArgumentError.new("field params should not be nil") unless field

      @data = data
      @field = field
    end

    def per_page
      self.data.try(:[], self.field).try(:[], "@attr").try(:[], "perPage").to_i
    end

    def total_count
      self.data.try(:[], self.field).try(:[], "@attr").try(:[], "total").to_i
    end

    def has_error?
      self.data.try(:[], "error").present?
    end

    def error_message
      has_error? ? self.data.try(:[], "message") : ""
    end
  end
end
