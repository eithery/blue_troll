describe "Authentication" do
  describe "sign in" do
    subject { page }
    before do
      visit root_path
      click_link 'Sign in'
    end

    it { should have_title('Sign in') }


    context "with valid information" do
      let(:user_account) { FactoryGirl.create(:user_account) }

      shared_examples_for "successfully redirected to user profile page" do
        it { should have_title(user_account.name) }
        it { should have_link 'Sign out' }
        it { should_not have_link 'Sign in' }
      end


      context "based on login" do
        before { submit_form user_account.login }
        it_behaves_like "successfully redirected to user profile page"
      end

      context "based on email" do
        before { submit_form user_account.email }
        it_behaves_like "successfully redirected to user profile page"
      end


  private
      def submit_form(login_or_email)
        fill_in 'Login or Email', with: login_or_email
        fill_in 'Password', with: user_account.password
        click_button 'Sign in'
      end
    end
  end
end
