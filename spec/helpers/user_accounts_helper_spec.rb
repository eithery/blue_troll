require 'spec_helper'

describe UserAccountsHelper do
  describe "gravatar_for" do
    let(:email) { 'gwen@gmail1.com' }
    let(:user) { mock_model(UserAccount, email: email) }

    it "returns image tag" do
      gravatar_for(user).should have_selector("img.gravatar")
    end

    it "loads image from gravatar web site" do
      gravatar_for(user).should =~ /http:\/\/www.gravatar.com\/avatar/
    end

    it "uses email to load image" do
      user.should_receive(:email).twice.and_return(email)
      gravatar_for(user)
    end
  end
end
