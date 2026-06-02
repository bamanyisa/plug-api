module Fineract
  class ClientsService
    def initialize(organization)
      @client = BaseClient.new(organization)
    end

    def create(borrower)
      @client.post("/clients", {
        firstname: borrower.first_name,
        lastname: borrower.last_name,
        externalId: borrower.fineract_external_id,
        mobileNo: borrower.phone,
        emailAddress: borrower.email,
        dateFormat: "yyyy-MM-dd",
        locale: "en"
      }.compact)
    end

    def find(id)
      @client.get("/clients/#{id}")
    end

    def update(id, attrs)
      @client.put("/clients/#{id}", attrs)
    end
  end
end
