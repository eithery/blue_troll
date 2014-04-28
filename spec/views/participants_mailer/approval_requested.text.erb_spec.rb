require 'spec_helper'

describe "participants_mailer/approval_requested.text.erb" do
  let(:participant) { stub_participant }
  let(:crew) { mock_crew }

  subject { rendered }
  before do
    assign(:participant, participant)
    assign(:crew, crew)
    render
  end

  it { should have_content("Поступил новый запрос от пассажира #{participant.display_name}") }
  it { should have_content("The new participant #{participant.display_name}") }
  it { should have_content("на Синий Троллейбус в группе '#{crew.native_name}'") }
  it { should have_content("would like to join to your crew '#{crew.name}'") }
end
