require "rails_helper"

feature "Super User - Users", type: :feature do
  fixtures :all

  before do
    sign_in users :admin1
    visit "/think_feel_do_dashboard"
    click_on "Users"
  end

  after do
    # click_on "Sign Out"
  end

  it "should enable the creation of a Super User" do
    expect(page).to_not have_text "Super User admin2@example.com"

    click_on "New"
    check "Super User"
    fill_in "Email", with: "admin2@example.com"
    click_on "Create"

    expect(page).to have_text "User was successfully created"
    expect(page).to have_text "Super User: Yes"
    expect(page).to have_text "Email: admin2@example.com"

    user = User.find_by_email("admin2@example.com")
    expect(user.is_admin).to be_truthy
  end

  it "should enable the updating of a Super User" do
    expect(page).to_not have_text "Super User clinician1@example.com"

    click_on "clinician1@example.com"

    expect(page).to have_text "Super User: No"
    expect(page).to have_text "Email: clinician1@example.com"
    expect(page).to_not have_text "Email: what@ex.co"
    expect(page).to_not have_text "Super User: Yes"
    expect(page).to_not have_text "Roles: Clinician and Researcher"

    click_on "Edit"
    check "Super User"
    check "Researcher"
    fill_in "Email", with: "what@ex.co"
    click_on "Update"

    expect(page).to have_text "User was successfully updated"
    expect(page).to have_text "Super User: Yes"
    expect(page).to_not have_text "Super User: No"
    expect(page).to_not have_text "Email: clinician1@example.com"
    expect(page).to have_text "Email: what@ex.co"
    expect(page).to have_text "Roles: Clinician and Researcher"

    visit "/think_feel_do_dashboard/users"

    expect(page).to have_text "Super User what@ex.co"

    click_on "Super User what@ex.co"
    click_on "Edit"
    uncheck "Super User"
    uncheck "Researcher"
    check "Clinician"
    check "Content Author"
    click_on "Update"

    expect(page).to have_text "Super User: No"
    expect(page).to_not have_text "Super User: Yes"
    expect(page).to_not have_text "Roles: Clinician and Researcher"
    expect(page).to have_text "Roles: Clinician and Content Author"

    click_on "Edit"
    click_on "Update"

    expect(page).to have_text "Roles: Clinician and Content Author"
  end
end
