class DisburseLoanJob < ApplicationJob
  def perform(organization_id, record_id)
    with_tenant(organization_id) do
      disbursement = Disbursement.find(record_id)
      response = Fineract::LoansService.new(disbursement.organization).disburse(
        disbursement.loan.fineract_loan_id,
        disbursement.amount,
        disbursement.disbursed_on,
        nil
      )

      disbursement.update!(
        status: "disbursed",
        fineract_transaction_id: response["resourceId"] || response["subResourceId"],
        fineract_transaction_ref: response["officeId"]&.to_s
      )
    end
  end
end
