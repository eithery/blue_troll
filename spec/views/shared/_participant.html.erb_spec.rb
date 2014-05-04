require 'spec_helper'

describe "shared/_participant.html.erb" do
  let!(:gwen) { mock_participant }

  subject { rendered }

  describe "in any case" do
    before { render_template }

    it { should have_content('4') }
    it { should have_selector('td', text: gwen.full_name) }
    it { should have_selector('td', text: gwen.email) }
    it { should have_selector('td', text: gwen.age) }

    it { should have_link("Click here to edit #{gwen.display_name}", href: edit_participant_path(gwen)) }
    it { should have_link("Click here to delete #{gwen.display_name}", href: participant_path(gwen)) }
    it { should have_link("Click here to download a ticket for #{gwen.display_name}",
      href: participant_ticket_path(participant_id: gwen.id)) }
  end

  specify do
    gwen.should_receive(:display_name).at_least(4).times
    render_template
  end

  specify do
    gwen.should_receive(:email).twice
    render_template
  end

  specify do
    gwen.should_receive(:age)
    render_template
  end


  context "when participant is NOT approved" do
    before do
      gwen.stub(:approved?).and_return(false)
      render_template
    end

    it "allows to edit participant details" do
      should have_selector("a img[alt='Edit participant']")
      should_not have_selector("a[disabled='disabled'] img[alt='Edit participant']")
    end

    it "allows to delete participant" do
      should have_selector("a img[alt='Delete participant']")
      should_not have_selector("a[disabled='disabled'] img[alt='Delete participant']")
    end
  end


  context "when participant is approved" do
    before do
      gwen.stub(:approved?).and_return(true)
      render_template
    end

    it "does NOT allow to edit participant details" do
      should have_selector("a[disabled='disabled'] img[alt='Edit participant']")
    end

    it "does NOT allow to delete participant" do
      should have_selector("a[disabled='disabled'] img[alt='Delete participant']")
    end
  end


  context "when participant is NOT paid for" do
    before do
      gwen.stub(:payment_confirmed?).and_return(false)
      render_template
    end

    it "does NOT allow to download ticket for participant" do
      should have_selector("a[disabled='disabled'], img[alt='Download ticket']")
    end
  end


  context "when participant is paid for" do
    before do
      gwen.stub(:payment_confirmed?).and_return(true)
      render_template
    end

    it "allows to download ticket for participant" do
      should have_selector("a img[alt='Download ticket']")
      should_not have_selector("a[disabled='disabled'] img[alt='Download ticket']")
    end
  end


private
  def render_template
    render 'shared/participant', participant: gwen, index: 3
  end
end
