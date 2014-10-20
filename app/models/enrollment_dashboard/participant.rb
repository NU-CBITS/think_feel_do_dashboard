module EnrollmentDashboard
  class Participant < ActiveRecord::Base
    validates :phone_number, allow_nil: true, uniqueness: true
  end
end
