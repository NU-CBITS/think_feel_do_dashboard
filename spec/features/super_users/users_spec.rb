require "spec_helper"

feature "Super User - Users", type: :feature do
  fixtures :all

  before do
    visit "/think_feel_do_dashboard/users"
  end

  it "should enable the creation of a Super User" do
    expect(page).to_not have_text "Admin admin2@example.com"

    click_on "New"
    check "Admin"
    fill_in "Email", with: "admin2@example.com"
    click_on "Create"

    expect(page).to have_text "User was successfully created"
    expect(page).to have_text "Admin: Yes"
    expect(page).to have_text "Email: admin2@example.com"

    user = User.find_by_email("admin2@example.com")
    expect(user.is_admin).to eq true
  end

  it "should enable the updating of a Super User" do
    expect(page).to_not have_text "Admin user1@example.com"

    click_on "user1@example.com"

    expect(page).to have_text "Admin: No"
    expect(page).to have_text "Email: user1@example.com"
    expect(page).to_not have_text "Email: What!"
    expect(page).to have_text "Groups"
    expect(page).to have_text "Group 2 · TFD-MO 2"
    expect(page).to_not have_text "Admin: Yes"
    expect(page).to_not have_text "Roles: Researcher"

    click_on "Edit"
    check "Admin"
    check "Researcher"
    fill_in "Email", with: "What!"
    click_on "Update"

    expect(page).to have_text "User was successfully updated"
    expect(page).to have_text "Admin: Yes"
    expect(page).to_not have_text "Admin: No"
    expect(page).to_not have_text "Email: user1@example.com"
    expect(page).to have_text "Email: What!"
    expect(page).to have_text "Roles: Researcher"

    with_scope "#main" do
      click_on "Users"
    end

    expect(page).to have_text "Admin What!"

    click_on "Admin What!"
    click_on "Edit"
    uncheck "Admin"
    uncheck "Researcher"
    check "Clinician"
    check "Content Author"
    click_on "Update"

    expect(page).to have_text "Admin: No"
    expect(page).to_not have_text "Admin: Yes"
    expect(page).to_not have_text "Roles: Researcher"
    expect(page).to have_text "Roles: Clinician and Content Author"

    click_on "Edit"
    click_on "Update"

    expect(page).to have_text "Roles: Clinician and Content Author"
  end
end