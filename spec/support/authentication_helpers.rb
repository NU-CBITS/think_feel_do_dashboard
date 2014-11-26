module AuthenticationHelpers
  def sign_in(user)
    visit think_feel_do_engine.new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "secrets!"
    click_on "Sign in"
  end
end