require 'spec_helper'
include UserRegistrationSpecHelper

describe "User account activation" do
  let(:invalid_code) { '12345678' }
  let(:activate_account) { 'Activate my account' }
  let(:base_activation_url) { "http://localhost:3000/activate?activation_token=" }
  let(:user) { FactoryGirl.build(:inactive_user) }

  before { register user }

  describe "by activation code" do
    describe "with correct activation code" do
      before { activate_by_code registered_user.activation_code }

      it_behaves_like "account is activated"
      it_behaves_like "sign in page with success activation message"
    end


    describe "with incorrect activation code" do
      before { activate_by_code invalid_code }

      it_behaves_like "account is not activated"
      it_behaves_like "activation page"
      it_behaves_like "invalid activation code message"
    end
  end


  describe "by activation link" do
    describe "with correct activation link" do
      before { activate_by_link registered_user.activation_token }

      it_behaves_like "account is activated"
      it_behaves_like "sign in page with success activation message"
    end


    describe "with incorrect activation link" do
      before { activate_by_link SecureRandom.uuid }

      it_behaves_like "account is not activated"
      it_behaves_like "home page"
      it_behaves_like "invalid activation link message"
    end
  end


private
  def activate_by_code(activation_code)
    fill_in 'Activation Code', with: activation_code
    click_button activate_account
    @user = registered_user
  end


  def activate_by_link(activation_token)
    visit base_activation_url + activation_token
    @user = registered_user
  end


  def registered_user
    UserAccount.find_by_login(user.login)
  end
end
