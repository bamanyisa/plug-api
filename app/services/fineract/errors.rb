module Fineract
  class Error < StandardError
    attr_reader :status, :fineract_errors

    def initialize(msg, status:, errors: [])
      super(msg)
      @status         = status
      @fineract_errors = errors
    end
  end

  class NotFoundError      < Error; end
  class ValidationError    < Error; end
  class UnauthorizedError  < Error; end
  class ConflictError      < Error; end

  module Errors
    def self.from_response(response)
      body     = response.body
      messages = Array(body["errors"]).map { |e| e["defaultUserMessage"] }.compact
      messages << body["defaultUserMessage"] if messages.empty? && body["defaultUserMessage"]
      msg = messages.any? ? messages.join(" · ") : "Fineract error (#{response.status})"

      case response.status
      when 400 then Fineract::ValidationError.new(msg,   status: 400, errors: messages)
      when 401 then Fineract::UnauthorizedError.new(msg, status: 401)
      when 403 then Fineract::UnauthorizedError.new(msg, status: 403)
      when 404 then Fineract::NotFoundError.new(msg,     status: 404)
      when 409 then Fineract::ConflictError.new(msg,     status: 409)
      else          Fineract::Error.new(msg,             status: response.status)
      end
    end
  end
end
