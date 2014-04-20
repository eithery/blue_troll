require 'spec_helper'

describe PasswordResetController do
  let(:reset_token) { SecureRandom.uuid }
  let(:user) { mock_model(UserAccount, login: 'gwen', email: 'gwen@gmail1.com',
  reset_password_token: reset_token).as_null_object }

  describe "GET collect_info" do
    it "renders new template" do
      get :collect_info
      response.should render_template(:collect_info)
    end
  end


  describe "POST send_link" do
    it "finds user by login" do
      UserAccount.stub(:find_by_email).and_return(nil)
      UserAccount.should_receive(:find_by_login).with(user.login).and_return(user)
      post_send_link user.login
    end

    it "finds user by email" do
      UserAccount.should_receive(:find_by_email).with(user.email).and_return(user)
      UserAccount.should_not_receive(:find_by_login)
      post_send_link
    end

    context "when login or email exists" do
      before { UserAccount.stub(:find_by_email).and_return(user) }

      it "assigns user" do
        post_send_link
        should_assign_user
      end

      it "calls generate_password_token" do
        user.should_receive(:generate_reset_token)
        post_send_link
      end

      it "sends email with reset password link" do
        UserAccountsMailer.deliveries.clear
        post_send_link
        mail = UserAccountsMailer.deliveries.last
        mail.to.should include(user.email)
        mail.subject.should == "Blue Trolley: password reset"
        mail.body.encoded.should have_content("pwd_reset?reset_token=#{user.reset_password_token}")
      end

      it "displays a flash success message" do
        post_send_link
        flash_success "Password reset link has been sent to #{user.email}"
      end

      it "redirects to sign in page" do
        post_send_link
        response.should redirect_to(signin_path)
      end
    end


    context "when login or email cannot be found" do
      before do
        UserAccount.stub(:find_by_email).and_return(nil)
        post_send_link
      end

      it { flash_warning "Entered user login or email is not found" }
      specify { response.should render_template(:collect_info) }
    end
  end


  describe "GET reset" do
    it "finds user account by reset_password_token" do
      UserAccount.should_receive(:find_by_reset_password_token).with(user.reset_password_token)
      get_reset
    end

    context "when password token is valid" do
      before { UserAccount.stub(:find_by_reset_password_token).and_return(user) }

      it "calls user account reset" do
        user.should_receive(:reset)
        get_reset
      end

      it "assigns user" do
        get_reset
        should_assign_user
      end

      it "displays a flash success message" do
        get_reset
        flash_success "Password has been reset. Please change the password"
      end

      it "redirects to change password template" do
        get_reset
        response.should redirect_to(change_password_path user)
      end
    end

    context "when password token is invalid" do
      before do
        UserAccount.stub(:find_by_reset_password_token).and_return(nil)
        get_reset
      end

      it { flash_warning "Invalid reset password link" }
      specify { response.should redirect_to(signin_path) }
    end
  end


private
  def post_send_link(login_or_email=user.email)
    post :send_link, login: login_or_email
  end

  def get_reset
    get :reset, reset_token: user.reset_password_token
  end

  def flash_success(message)
    flash[:success].should == message
  end

  def flash_warning(message)
    flash[:warning].should == message
  end

  def should_assign_user
    assigns[:user].should eq(user)
  end
end
