module Fineract
  class StaffService
    def initialize(organization, token)
      @client = BaseClient.new(organization, token)
    end

    def create_staff(user)
      response = @client.post("/staff", {
        firstname: user.email.split("@").first,
        lastname: user.organization.slug,
        officeId: 1,
        isLoanOfficer: true,
        isActive: true,
        mobileNo: "N/A",
        joiningDate: Date.current.strftime("%Y-%m-%d"),
        locale: "en",
        dateFormat: "yyyy-MM-dd"
      })
      response["resourceId"]
    end

    def create_appuser(user, staff_id)
      response = @client.post("/users", {
        username: user.fineract_username || user.email,
        firstname: user.email.split("@").first,
        lastname: user.organization.slug,
        email: user.email,
        staffId: staff_id,
        officeId: 1,
        locale: "en"
      })
      response["resourceId"]
    end
  end
end
