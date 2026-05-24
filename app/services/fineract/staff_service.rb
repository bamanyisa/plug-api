module Fineract
  class StaffService
    def initialize(organization)
      @client = BaseClient.new(organization)
    end

    # TODO: implement
  end
end
