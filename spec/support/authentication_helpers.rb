module AuthenticationHelpers
  def sign_in(user)
    visit "/users/sign_in"
    fill_in "Email", with: user.email
    fill_in "Password", with: "secrets!"
    click_on "Log in"
  end
end
