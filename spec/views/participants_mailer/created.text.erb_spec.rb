require 'spec_helper'

describe "participants_mailer/created.text.erb" do
  let(:participant) { stub_participant }
  let(:crew) { mock_crew }

  subject { rendered }
  before do
    assign(:participant, participant)
    assign(:crew, crew)
    render
  end

  it { should have_content("Уважаемый пассажир, #{participant.display_name}!") }
  it { should have_content("Dear participant, #{participant.display_name}!") }
  it { should have_content("в группе '#{crew.native_name}' послан кондуктору") }
  it { should have_content("Your request to join to '#{crew.name}' has been sent to the crew lead") }
end
