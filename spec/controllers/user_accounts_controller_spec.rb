require 'spec_helper'

describe UserAccountsController do
  let(:name) { 'gwen' }
  let(:email) { 'gwen@gmail1.com' }
  let(:user) { mock_user_account(name: name, email: email) }
  let(:congratulation) { "Congratulation, #{name}! Your account has been successfully activated." }

  before { UserAccount.stub(:find).and_return(user) }

  describe "GET new" do
    it "creates a new user account" do
      UserAccount.should_receive(:new)
      get :new
    end

    it "renders the new template" do
      get :new
      response.should render_template(:new)
    end
  end


  describe "POST create" do
    before { UserAccount.stub(:new).and_return(user) }


    it "creates a new user account" do
      UserAccount.should_receive(:new).with({"email" => "#{email}"}).and_return(user)
      post_create
    end

    it "saves the user account" do
      user.should_receive(:save)
      post_create
    end

    it { should_assign(user: user) { post_create } }


    context "when user account saves successfully" do
      before { user.stub(:name).and_return('gwen') }

      specify { expect_to_flash_success("New user account for #{name} has been created.") { post_create } }

      it { expect_to_send_email(UserAccountsMailer, to: email,
        subject: "#{sender}: #{registered_subject}") { post_create } }

      it "redirects to activation page" do
        notifier = double('notifier').as_null_object
        UserAccountsMailer.stub(:registered).and_return(notifier)
        post_create
        response.should redirect_to(request_to_activate_path account_id: user.id)
      end
    end


    context "when user account fails to save" do
      before do
        user.stub(:save).and_return(false)
        post_create
      end

      it { should render_template(:new) }
    end
  end


  describe "GET show" do
    it "finds user account by id" do
      UserAccount.should_receive(:find).with("#{user.id}").and_return(user)
      get_show
    end

    it { should_assign(user: user) { get_show } }

    it "renders the show template" do
      get_show
      response.should render_template(:show)
    end
  end


  describe "GET request_to_activate" do
    it "finds user account by account_id" do
      UserAccount.should_receive(:find).with("#{user.id}").and_return(user)
      get_request_to_activate
    end

    it { should_assign(user: user) { get_request_to_activate } }

    it "renders the request_to_activate template" do
      get_request_to_activate
      response.should render_template(:request_to_activate)
    end
  end


  describe "POST activate" do
    it "finds user account by id" do
      UserAccount.should_receive(:find).with("#{user.id}").and_return(user)
      post_activate
    end

    it "activates a user account" do
      user.stub(:activation_code).and_return('123456789')
      user.should_receive(:activate).with(user.activation_code)
      post_activate
    end

    context "when a user account activates successfully" do
      before do
        user.stub(:activate).and_return(true)
        post_activate
      end

      specify { expect_to_flash_success congratulation }
      it { should redirect_to(signin_path) }
    end


    context "when a user account fails to activate" do
      before do
        user.stub(:activate).and_return(false)
        post_activate
      end

      specify { expect_to_flash_error "Invalid activation code." }
      it { should redirect_to(request_to_activate_path account_id: user.id) }
    end
  end


  describe "GET activate_by_link" do
    before { user.stub(:activation_token).and_return(SecureRandom.uuid) }

    it "finds a user account by the activation token" do
      UserAccount.should_receive(:find_by_activation_token).with(user.activation_token).and_return(user)
      get_activate
    end

    context "when the activation token is valid" do
      before { UserAccount.stub(:find_by_activation_token).and_return(user) }

      it "activates a user account" do
        user.should_receive(:activate).with(user.activation_token)
        get_activate
      end

      specify { expect_to_flash_success(congratulation) { get_activate } }

      it "redirects to the root page" do
        get_activate
        response.should redirect_to(signin_path)
      end
    end

    context "when the activation token is not valid" do
      before { get_activate 'invalid_activation_token' }

      specify { expect_to_flash_error "Invalid or expired activation link." }
      it { should redirect_to(root_path) }
    end
  end


  describe "GET change_password" do
    it "finds user account by id" do
      UserAccount.should_receive(:find).with("#{user.id}")
      get_change_password
    end

    it { should_assign(user: user) { get_change_password } }

    it "renders change password template" do
      get_change_password
      response.should render_template(:change_password)
    end
  end


  describe "POST change_password" do
    it "finds user account by id" do
      UserAccount.should_receive(:find).with("#{user.id}")
      put_update_password
    end

    it { should_assign(user: user) { put_update_password } }

    it "sets password attributes" do
      user.should_receive(:password).with(user.password)
      user.should_receive(:password_confirmation).with(user.password_confirmation)
      put_update_password
    end

    it "saves the user account" do
      user.should_receive(:save)
      put_update_password
    end

    it { expect_to_send_email(UserAccountsMailer, to: email,
      subject: "#{sender}: #{password_changed_subject}") { put_update_password } }

    context "when a new password saves successfully" do
      subject { response }
      before { put_update_password }

      specify { expect_to_flash_success "Password has been changed successfully." }
      it { should redirect_to(signin_path) }
    end

    context "when a new password failes to update" do
      subject { response }
      before do
        user.stub(:save).and_return(false)
        put_update_password
      end

      it { should render_template(:change_password) }
    end
  end


  private
    def post_create
      post :create, user_account: { email: email }
    end

    def get_show
      get :show, id: user.id
    end

    def get_request_to_activate
      get :request_to_activate, account_id: user.id
    end

    def post_activate
      post :activate, activation: { user_account: user.id, code: user.activation_code }
    end

    def get_activate(activation_token=user.activation_token)
      get :activate_by_link, activation_token: activation_token
    end

    def get_change_password
      get :change_password, id: user.id
    end

    def put_update_password
      put :update_password, id: user.id, user_account: { password: user.password, password_confirmation: user.password }
    end
end
