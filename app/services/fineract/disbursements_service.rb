module Fineract
  class DisbursementsService
    def initialize(organization, token)
      @client = BaseClient.new(organization, token)
    end

    # TODO: implement
  end
end
