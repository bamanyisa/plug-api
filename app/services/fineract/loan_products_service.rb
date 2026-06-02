module Fineract
  class LoanProductsService
    def initialize(organization, token)
      @client = BaseClient.new(organization, token)
    end

    def create(loan_product)
      @client.post("/loanproducts", {
        name: loan_product.name,
        shortName: loan_product.short_name,
        currencyCode: loan_product.currency_code,
        digitsAfterDecimal: loan_product.currency_decimal_places,
        minPrincipal: loan_product.min_principal,
        maxPrincipal: loan_product.max_principal,
        principal: loan_product.default_principal,
        interestRatePerPeriod: loan_product.nominal_interest_rate,
        repaymentEvery: loan_product.repayment_every,
        numberOfRepayments: loan_product.number_of_repayments,
        amortizationType: loan_product.amortization_type,
        interestType: loan_product.interest_type,
        repaymentFrequencyType: loan_product.repayment_frequency,
        locale: "en"
      }.compact)
    end

    def find(id)
      @client.get("/loanproducts/#{id}")
    end
  end
end
