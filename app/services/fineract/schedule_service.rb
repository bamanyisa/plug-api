module Fineract
  class ScheduleService
    def initialize(organization)
      @client = BaseClient.new(organization)
    end

    def get(fineract_loan_id)
      @client.get("/loans/#{fineract_loan_id}/repaymentschedule")
    end
  end
end
