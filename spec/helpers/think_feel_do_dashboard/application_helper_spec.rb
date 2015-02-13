require "rails_helper"

RSpec.describe ThinkFeelDoDashboard::ApplicationHelper, type: :helper do
  describe "#breadcrumbs" do
    context "controller name not among top level controllers" do
      it "does not render breadcrumbs" do
        allow(helper).to receive(:controller_name) { "baz" }

        expect(helper.tap(&:breadcrumbs).content_for(:breadcrumbs))
          .to be_nil
      end
    end

    context "no resource matches controller name" do
      before { allow(helper).to receive(:controller_name) { "reports" } }

      it "renders the resource index breadcrumb" do
        expect(helper.tap(&:breadcrumbs).content_for(:breadcrumbs))
          .to match(/Reports/)
      end
    end

    context "authorized" do
      before do
        allow(helper).to receive(:can?).with(:index, Participant) { true }
      end

      context "resource matches controller name" do
        before { allow(helper).to receive(:controller_name) { "participants" } }

        it "renders the resource index breadcrumb" do
          expect(helper.tap(&:breadcrumbs).content_for(:breadcrumbs))
            .to match(/Participants/)
        end
      end
    end
  end
end
