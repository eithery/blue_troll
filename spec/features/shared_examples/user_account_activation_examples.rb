module UserAccountActivationExamples
  shared_examples_for "account is activated" do
    specify { @user.should be_active }
  end

  shared_examples_for "account is not activated" do
    specify { @user.should_not be_active }
  end

  shared_examples_for "sign in page with success activation message" do
    it_behaves_like "sign in page"
    specify { page.should have_selector('.alert-success',
      text: "Congratulation, #{@user.name}! Your account has been successfully activated") }
  end

  shared_examples_for "invalid activation code message" do
    specify { page.should have_selector('.alert-danger', text: 'Invalid activation code') }
  end

  def user_account
    UserAccount.find_by_email(@user.email)
  end
end
