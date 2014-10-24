module ThinkFeelDoDashboard
  # There are two projects - an adolescent and an adult
  # These projects have many arms to each one with between
  # Between 1 and 8 groups are in each arm.
  class Project < ActiveRecord::Base
    has_many :arms, dependent: :destroy
  end
end
