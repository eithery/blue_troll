require 'spec_helper'

describe "participants_mailer/approved.text.erb" do
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
  it { should have_content("Кондуктор группы '#{crew.native_name}' подтверждает") }
  it { should have_content("you are actually the member of '#{crew.name}' crew.") }
end
