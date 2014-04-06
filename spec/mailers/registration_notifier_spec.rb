require "spec_helper"

describe RegistrationNotifier do
  describe "#registered" do
    let(:user) { FactoryGirl.build(:inactive_user) }
    let(:mail) { RegistrationNotifier.registered(user) }

    it "renders the headers" do
      mail.subject.should == "Blue Trolley club account activation"
      mail.to.should include(user.email)
      mail.from.should include('bluetrolley2014@gmail.com')
    end


    it "renders the body" do
      mail.body.encoded.should =~ /Thank you for registering in Blue Trolley club./
    end
  end
end
