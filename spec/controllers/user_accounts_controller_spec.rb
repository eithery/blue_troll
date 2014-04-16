require 'spec_helper'

describe UserAccountsController do
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
    let(:name) { 'gwen' }
    let(:email) { 'gwen@gmail1.com' }
    let(:user) { mock_model(UserAccount, email: email).as_null_object }
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
      it "sets a flash[:success] message" do
        user.stub(:name).and_return('gwen')
        post_create
        flash[:success].should == "New user account for #{name} has been created."
      end


      it "sends a user account registration notification email" do
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
      it "renders the new template" do
        user.stub(:save).and_return(false)
        post_create
        response.should render_template(:new)
      end
    end

  private
    def post_create
      post :create, user_account: { email: email }
    end
  end


  describe "GET show" do
  end


  describe "GET request_to_activate" do
  end


  describe "POST activate" do
  end


  describe "GET activate_by_link" do
  end
end
