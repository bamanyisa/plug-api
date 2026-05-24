module Fineract
  class ClientsService
    def initialize(organization)
      @client = BaseClient.new(organization)
    end

    # TODO: implement
  end
end
