require 'spec_helper'

describe UserAccountsController do
  let(:name) { 'gwen' }
  let(:email) { 'gwen@gmail1.com' }
  let(:user) { mock_model(UserAccount, name: name, email: email).as_null_object }
  let(:congratulation) { "Congratulation, #{name}! Your account has been successfully activated" }


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

    it "assigns user" do
      post_create
      assigns[:user].should eq(user)
    end


    context "when user account saves successfully" do
      it "sets a flash success message" do
        user.stub(:name).and_return('gwen')
        post_create
        flash[:success].should == "New user account for #{name} has been created."
      end


      it "sends a user account registration notification email" do
        RegistrationNotifier.deliveries.clear
        post_create
        mail = RegistrationNotifier.deliveries.first
        mail.to.should include(email)
        mail.subject.should == "Blue Trolley club account activation"
      end


      it "redirects to activation page" do
        notifier = double('notifier').as_null_object
        RegistrationNotifier.stub(:registered).and_return(notifier)
        post_create
        response.should redirect_to(request_to_activate_path(account_id: user.id))
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
    before { UserAccount.stub(:find).and_return(user) }

    it "finds user account by id" do
      UserAccount.should_receive(:find).with("#{user.id}").and_return(user)
      get_show
    end

    it "assigns user" do
      get_show
      assigns[:user].should eq(user)
    end

    it "renders the show template" do
      get_show
      response.should render_template(:show)
    end
  end


  describe "GET request_to_activate" do
    before { UserAccount.stub(:find).and_return(user) }

    it "finds user account by account_id" do
      UserAccount.should_receive(:find).with("#{user.id}").and_return(user)
      get_request_to_activate
    end

    it "assigns user" do
      get_request_to_activate
      assigns[:user].should eq(user)
    end

    it "renders the request_to_activate template" do
      get_request_to_activate
      response.should render_template(:request_to_activate)
    end
  end


  describe "POST activate" do
    before { UserAccount.stub(:find).and_return(user) }

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

      it "sets a flash activation success message" do
        flash[:success].should == congratulation
      end

      it { should redirect_to(signin_path) }
    end


    context "when a user account fails to activate" do
      before do
        user.stub(:activate).and_return(false)
        post_activate
      end

      it "sets a flash activation error message" do
        flash[:danger].should == "Invalid activation code"
      end

      it { should redirect_to(request_to_activate_path(account_id: user.id)) }
    end
  end


  describe "GET activate_by_link" do
    before { user.stub(:activation_code).and_return('123456789') }

    it "finds a user account by the activation code" do
      UserAccount.should_receive(:find_by_activation_code).with(user.activation_code).and_return(user)
      get_activate
    end

    context "when the activation code is valid" do
      before { UserAccount.stub(:find_by_activation_code).and_return(user) }

      it "activates a user account" do
        user.should_receive(:activate).with(user.activation_code)
        get_activate
      end

      it "sets a flash activation success message" do
        get_activate
        flash[:success].should == congratulation
      end

      it "redirects to the root page" do
        get_activate
        response.should redirect_to(signin_path)
      end
    end


    context "when the activation code is not valid" do
      before { get_activate 'invalid_activation_link' }

      it "sets a flash activation error message" do
        flash[:danger].should == "Invalid activation code"
      end

      it { should redirect_to(root_path) }
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

    def get_activate(activation_code=user.activation_code)
      get :activate_by_link, activation_id: activation_code
    end
end
