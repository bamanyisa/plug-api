module Fineract
  class DisbursementsService
    def initialize(organization)
      @client = BaseClient.new(organization)
    end

    # TODO: implement
  end
end
