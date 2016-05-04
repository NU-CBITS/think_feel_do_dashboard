if Rails::VERSION::MAJOR == 5
  require "rails-controller-testing"
end

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
  if Rails::VERSION::MAJOR == 5
    config.include ::Rails::Controller::Testing::TemplateAssertions,
                   type: :controller
  end
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerSpecHelpers, type: :controller
end

# Shared examples

RSpec.shared_examples "a rejected user action" do
  it "should redirect to the user login" do
    expect(response).to redirect_to "/users/sign_in"
  end
end

RSpec.shared_examples "a rejected participant action" do
  it "should redirect to the participant login" do
    expect(response).to redirect_to "/participants/sign_in"
  end
end

RSpec.shared_examples "an untrusted action" do
  it "should redirect to root path" do
    expect(response.status)
      .to redirect_to root_path
  end

  it "should redirect to root path" do
    expect(flash[:alert])
      .to eq "Your authenticity token expired. Please try again."
  end
end
