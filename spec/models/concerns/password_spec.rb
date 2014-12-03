require "spec_helper"

describe "Password" do
  fixtures :all

  let(:participant) { participants(:participant1) }

  describe "before_validation" do
    context "new participant creation" do
      it "sets a new password for the participant" do
        Participant.create(email: "new@email.com", contact_preference: "email", study_id: "s12")
        expect(Participant.find_by_email("new@email.com").encrypted_password).to_not be_nil
      end
    end
    context "updating participant" do
      it "does not change the password on update" do
        old_password = participant.encrypted_password
        participant.update(email: "new@email.com")
        expect(participant.encrypted_password).to eq old_password
      end
    end
  end
end
