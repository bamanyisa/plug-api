module Fineract
  class LoansService
    def initialize(organization, token)
      @client = BaseClient.new(organization, token)
    end

    def submit(application)
      @client.post("/loans", {
        clientId: application.borrower.fineract_client_id,
        productId: application.loan_product.fineract_product_id,
        principal: application.requested_amount,
        loanTermFrequency: application.requested_term,
        submittedOnDate: Date.current.strftime("%Y-%m-%d"),
        loanType: "individual",
        locale: "en",
        dateFormat: "yyyy-MM-dd"
      }.compact)
    end

    def approve(id, date)
      @client.post("/loans/#{id}/commands?command=approve", {
        approvedOnDate: date.strftime("%Y-%m-%d"),
        locale: "en",
        dateFormat: "yyyy-MM-dd"
      })
    end

    def reject(id, date, reason)
      @client.post("/loans/#{id}/commands?command=reject", {
        rejectedOnDate: date.strftime("%Y-%m-%d"),
        note: reason,
        locale: "en",
        dateFormat: "yyyy-MM-dd"
      })
    end

    def disburse(id, amount, date, payment_type_id)
      @client.post("/loans/#{id}/disbursements", {
        actualDisbursementDate: date.strftime("%Y-%m-%d"),
        transactionAmount: amount,
        paymentTypeId: payment_type_id,
        locale: "en",
        dateFormat: "yyyy-MM-dd"
      }.compact)
    end
  end
end
