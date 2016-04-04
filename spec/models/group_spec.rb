require "rails_helper"

describe Group do
  fixtures :all

  describe "creation of moderator" do
    let(:social_arm) { arms(:arm1) }
    let(:clinician2) { users(:user2) }

    context "Configuring App Display Name" do
      before do
        allow(Rails).to receive_message_chain(:application, :config, :moderating_participant_display_name).and_return("SunnySide")
      end

      it "names a moderating participant based on per-app config" do
        group = social_arm.groups.create!(title: "Group with moderator", moderator_id: clinician2.id)
        moderating_participant = group.moderating_participant
        moderating_participant.reload

        expect(moderating_participant).to_not be_nil
        expect(moderating_participant.is_admin).to be_truthy
        expect(moderating_participant.display_name).to eq "SunnySide"
        expect(moderating_participant.email).to_not be_nil
      end
    end

    context "Social Arms" do
      let(:group) { social_arm.groups.create!(title: "Group with moderator", moderator_id: clinician2.id) }

      it "creates a moderating participant" do
        moderating_participant = group.moderating_participant
        moderating_participant.reload

        expect(moderating_participant).to_not be_nil
        expect(moderating_participant.is_admin).to be_truthy
        expect(moderating_participant.display_name).to eq "ThinkFeelDo"
        expect(moderating_participant.email).to_not be_nil
      end

      it "creates a social networking profile" do
        moderating_participant = group.moderating_participant

        p = SocialNetworking::Profile.find_by_participant_id(moderating_participant.id)
        expect(p).to_not be_nil
        expect(p.icon_name).to eq "admin"
        expect(p.active).to be_truthy
      end

      it "doesn't allow an 'is admin' participant's is_admin attribute to be updated" do
        moderating_participant = group.moderating_participant
        moderating_participant.update_attributes(is_admin: false)
        moderating_participant.reload

        expect(moderating_participant).to_not be_nil
        expect(moderating_participant.is_admin).to be_truthy
        expect(moderating_participant.errors.full_messages.include?("Is admin can't be updated.")).to be_truthy
      end

      it "allows other attributes can be updated" do
        moderating_participant = group.moderating_participant
        moderating_participant.update_attributes(contact_preference: "email")
        moderating_participant.reload

        expect(moderating_participant.errors.full_messages.include?("Is admin can't be updated.")).to_not be_truthy
      end

      it "doesn't allow a moderating participant to be deleted" do
        moderating_participant = group.moderating_participant
        moderating_participant.destroy
        moderating_participant.reload

        expect(moderating_participant.errors.full_messages.include?("Is admin can't be destroyed.")).to be_truthy
      end

      describe "saving" do
        let(:invalid_group) do
          Group.new(
            arm_id: social_arm.id,
            moderator_id: clinician2.id,
            title: "Test")
        end

        describe "when invalid" do
          before do
            allow_any_instance_of(Participant)
              .to receive(:valid?) { false }
          end

          it "moderator is not created" do
            expect { invalid_group.save! }
              .to raise_error(ActiveRecord::RecordInvalid)
            expect { invalid_group.save }
              .to_not change { Membership.count }
            expect { invalid_group.save }
              .to_not change { Participant.count }
            expect { invalid_group.save }
              .to_not change { SocialNetworking::Profile.count }
          end
        end
      end

      describe ".create" do
        let(:valid_group) do
          Group.create!(
            arm_id: social_arm.id,
            moderator_id: clinician2.id,
            title: "Test")
        end

        before do
          valid_group.reload
        end

        it "sets a participant to be active almost a year later" do
          Timecop.travel Time.zone.today.advance(days: 365) do
            expect(valid_group.moderating_participant)
              .to_not be_nil
          end
        end

        it "sets a participant to be inactive a year later" do
          Timecop.travel Time.zone.today.advance(days: 366) do
            expect(valid_group.moderating_participant)
              .to be_nil
          end
        end
      end
    end

    context "Non-Social Arms" do
      let(:non_social_arm) { arms(:arm2) }
      let(:clinician2) { users(:user2) }
      let(:non_social_group) { Group.create!(arm_id: non_social_arm.id, title: "Group without moderator", moderator_id: clinician2.id) }

      it "doesn't assign a moderating participant upon creation for non-social arms" do
        expect(non_social_group.moderating_participant).to be_nil
      end

      it "doesn't allow a moderating participant to become a member of a group in a non-social arm" do
        membership = non_social_group.memberships.create(
          participant_id: participants(:moderator_for_group1).id,
          start_date: Time.zone.today,
          end_date: Time.zone.today.advance(weeks: 8)
        )

        expect(membership.errors.full_messages.include?("moderators can't be part of this group.")).to be_truthy
      end
    end
  end
end
