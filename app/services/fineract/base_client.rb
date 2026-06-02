module Fineract
  class BaseClient
    API_PATH = "/fineract-provider/api/v1"

    def initialize(organization, token)
      @org   = organization
      @token = token
    end

    def get(path, params = {})
      response = connection.get("#{API_PATH}#{path}", params) { |r| r.headers.merge!(headers) }
      handle(response)
    end

    def post(path, body = {})
      response = connection.post("#{API_PATH}#{path}") { |r| r.headers.merge!(headers); r.body = body }
      handle(response)
    end

    def put(path, body = {})
      response = connection.put("#{API_PATH}#{path}") { |r| r.headers.merge!(headers); r.body = body }
      handle(response)
    end

    def warmup
      connection.get("#{API_PATH}/offices") { |r| r.headers.merge!(headers) }
    rescue StandardError => e
      Rails.logger.warn("Fineract warmup failed for #{@org.fineract_tenant_id}: #{e.message}")
    end

    private

    def connection
      @connection ||= Faraday.new(url: @org.fineract_base_url) do |f|
        f.request  :json
        f.response :json
        f.request  :retry, max: 3, interval: 0.5, backoff_factor: 2,
                           exceptions: [Faraday::ConnectionFailed, Faraday::TimeoutError]
        f.adapter  Faraday.default_adapter
      end
    end

    def headers
      {
        "fineract-platform-tenantid" => @org.fineract_tenant_id,
        "Authorization"              => "Bearer #{@token}",
        "Content-Type"               => "application/json"
      }
    end

    def handle(response)
      return response.body if response.success?
      raise Fineract::Errors.from_response(response)
    end
  end
end
