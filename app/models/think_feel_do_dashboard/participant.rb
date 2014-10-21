module ThinkFeelDoDashboard
  class Participant < ActiveRecord::Base
    validates :phone_number, allow_nil: true, uniqueness: true

    # test...
    def name
      email
    end

  end
end
