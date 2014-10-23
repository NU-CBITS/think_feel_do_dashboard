# module ThinkFeelDoDashboard
  class Project < ActiveRecord::Base
    has_many :arms, dependent: :destroy
  end
# end
