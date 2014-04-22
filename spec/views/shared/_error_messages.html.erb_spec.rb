require 'spec_helper'

shared_examples_for "view with errors" do
  it { should have_selector('div.panel') }
  it { should have_selector('button.close') }
  it { should have_selector('li', text: "Last name can't be blank") }
end


describe "shared/_error_messages.html.erb" do
  subject { rendered }
  let(:participant) { stub_participant }
  let(:errors_header) { "prohibited this participant from being saved:" }

  before do
    participant.crew = stub_model(Crew)
    participant.user_account = stub_model(UserAccount)
  end

  context "with no errors" do
    before { render_view }

    it { should be_empty }
    it { should_not have_selector('div') }
  end


  context "with one error" do
    before do
      participant.last_name = nil
      render_view
    end

    it_behaves_like "view with errors"

    it { should have_content("1 error " + errors_header) }
    it { should have_selector('li', count: 1) }
  end


  context "with many errors" do
    before do
      participant.user_account = nil
      participant.crew = nil
      participant.first_name = nil
      participant.last_name = nil
      render_view
    end

    it_behaves_like "view with errors"

    it { should have_content("4 errors " + errors_header) }
    it { should have_selector('li', minimum: 4) }
  end


private
  def render_view
    participant.valid?
    render "shared/error_messages", errors: participant.errors, entity_name: 'participant'
  end
end
