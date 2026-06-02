module Fineract
  class Error < StandardError
    attr_reader :status, :fineract_errors

    def initialize(msg, status:, errors: [])
      super(msg)
      @status          = status
      @fineract_errors = errors
    end
  end
end
