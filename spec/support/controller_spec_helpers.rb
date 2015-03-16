module ControllerSpecHelpers
  def sign_in_participant(participant = double("participant"))
    sign_in_resource(participant, "participant")
  end

  def sign_in_user(user = double("user"))
    sign_in_resource(user, "user")
  end

  private

  # rubocop:disable all
  def sign_in_resource(resource, name)
    if resource.nil?
      expect(request.env["warden"]).to receive(:authenticate!)
        .and_throw(:warden, scope: :"#{ name }")
      controller.stub :"current_#{ name }" => nil
    else
      expect(request.env["warden"]).to receive(:authenticate!) { resource }
      allow(controller).to receive("current_#{ name }") { resource }
    end
  end
  # rubocop:enable all
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerSpecHelpers, type: :controller
end

# Shared examples

shared_examples "a rejected user action" do
  it "should redirect to the user login" do
    expect(response).to redirect_to "/users/sign_in"
  end
end

shared_examples "a rejected participant action" do
  it "should redirect to the participant login" do
    expect(response).to redirect_to "/participants/sign_in"
  end
end
