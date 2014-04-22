require 'spec_helper'

describe SessionsHelper do
  subject { helper }
  let(:remember_token) { SecureRandom.urlsafe_base64 }
  let(:user) { mock_user_account remember_token: remember_token }

  describe "#sign_in" do
    it "creates permanent cookie" do
      sign_in(user)
      cookies.permanent[:remember_token].should_not be_empty
    end

    it "uses remember token to save it in cookie" do
      user.should_receive(:remember_token).and_return(remember_token)
      sign_in(user)
    end

    it "sets current user" do
      sign_in(user)
      current_user.should eq(user)
    end
  end


  describe "#sign_out" do
    before do
      sign_in(user)
      sign_out
    end

    it "resets current user" do
      current_user.should be_nil
    end

    it "deletes permanent cookie" do
      cookies.permanent[:remember_token].should be_nil
    end
  end


  describe "#current_user" do
    it "retrieves current user by remember token" do
      UserAccount.should_receive(:find_by_remember_token).with(nil)
      current_user
    end
  end


  describe "#signed_in?" do
    context "when user is signed in" do
      before { sign_in(user) }
      it { should be_signed_in }
    end

    context "when user is not signed in" do
      it { should_not be_signed_in }
    end
  end
end
