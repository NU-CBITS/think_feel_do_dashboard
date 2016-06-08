# frozen_string_literal: true
require "rails_helper"

class WozzleReport
end

feature "Researcher - Reports", type: :feature do
  fixtures :all

  before do
    allow(Rails.application.config).to receive(:reports)
      .and_return([{ title: "Wozzles", id: :wozzles, klass: WozzleReport }])
    sign_in users :researcher1
    visit "/think_feel_do_dashboard"
    click_on "CSV Reports"
  end

  it "displays the reports that exist" do
    expect(page).to have_link "Wozzles"
  end
end
