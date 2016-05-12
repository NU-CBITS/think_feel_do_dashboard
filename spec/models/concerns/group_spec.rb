require "rails_helper"

describe "Group concern" do
  fixtures :all

  describe "before_validation" do
    describe "creating a moderator" do
      let(:participant) do
        Participant.create!(
          contact_preference: "email",
          study_id: "bar",
          email: "foo@ex.com"
        )
      end

      it "augments default password to ensure validity" do
        allow(SecureRandom).to receive(:base64) { "weak" }

        expect(Participant)
          .to receive(:create!)
          .with(
            password: "1Aaw e a k ",
            password_confirmation:  anything,
            contact_preference: anything,
            display_name: anything,
            email: anything,
            is_admin: true,
            study_id: anything
          )
          .and_return(participant)

        Group.create!(
          title: "Valid",
          arm: arms(:arm1),
          moderator: users(:clinician1)
        )
      end
    end
  end
end
