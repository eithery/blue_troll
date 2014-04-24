require 'spec_helper'

describe "User account activation" do
  let(:invalid_code) { '12345678' }
  let(:base_activation_url) { "http://localhost:3000/activate?activation_token=" }
  let(:user) { FactoryGirl.create(:inactive_user) }

  subject { page }

  shared_examples_for "successful user activation" do
    specify { user.should be_active }
    it { should be_navigated_to signin_page }
    it { should display_message "Congratulation, #{user.name}! Your account has been successfully activated" }
  end

  specify { user.should_not be_active }

  describe "by activation code" do
    before { visit request_to_activate_path(account_id: user.id ) }

    it { should be_navigated_to activation_page(user) }
    specify { user.activation_code.should_not be_blank }

    context "with correct activation code" do
      before { activate_by_code user.activation_code }
      it_behaves_like "successful user activation"
    end


    context "with incorrect activation code" do
      before { activate_by_code invalid_code }

      specify { user.should_not be_active }
      it { should be_navigated_to activation_page(user) }
      it { should display_error 'Invalid activation code' }
    end
  end


  describe "by activation link" do
    specify { user.activation_token.should_not be_blank }

    context "with correct activation link" do
      before { activate_by_link user.activation_token }
      it_behaves_like "successful user activation"
    end


    context "with incorrect activation link" do
      before { activate_by_link SecureRandom.uuid }

      specify { user.should_not be_active }
      it { should be_navigated_to home_page}
      it { should display_error 'Invalid or expired activation link' }
    end
  end


private
  def activate_by_code(activation_code)
    fill_in 'Activation Code', with: activation_code
    click_button 'Activate my account'
    user.reload
  end


  def activate_by_link(activation_token)
    visit base_activation_url + activation_token
    user.reload
  end
end
