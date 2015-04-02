require "rails_helper"

RSpec.describe ThinkFeelDoDashboard::MembershipsHelper, type: :helper do
  describe "#projected_end_date" do
    it "should return a projected end date based on the membership start date" do
      Rails.application.config.study_length_in_weeks = 8
      membership = double("membership", start_date: Date.parse("2010-01-01"))
      expect(projected_end_date(membership)).to eq("02/26/2010")
    end

    it "should return a projected end date from 'today' if start_date is nil" do
      Rails.application.config.study_length_in_weeks = 8
      membership = double("membership", start_date: nil)
      expect(projected_end_date(membership)).to eq("10/27/2008")
    end
  end
end
