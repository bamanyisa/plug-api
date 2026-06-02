module Fineract
  class ScheduleService
    def initialize(organization, token)
      @client = BaseClient.new(organization, token)
    end

    def get(fineract_loan_id)
      @client.get("/loans/#{fineract_loan_id}/repaymentschedule")
    end
  end
end
