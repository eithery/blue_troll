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
    it "creates a new user account" do
      user = mock_model(UserAccount).as_null_object
      UserAccount.should_receive(:new).with({"login" => "gwen"}).and_return(user)
      post :create, user_account: { login: 'gwen' }
    end


    it "saves the user account" do
      user = mock_model(UserAccount).as_null_object
      UserAccount.stub(:new).and_return(user)
      user.should_receive(:save)
      post :create, user_account: { login: 'gwen' }
    end


    it "assigns user" do
      user = mock_model(UserAccount).as_null_object
      UserAccount.stub(:new).and_return(user)
      post :create, user_account: { login: 'gwen' }
      assigns[:user].should eq(user)
    end


    context "when user account saves successfully" do
      let(:user) do
        stub_model(UserAccount, save: true, name: 'gwen', email: 'gwen@gmail1.com')
      end

      it "sets a flash[:success] message" do
        user = mock_model(UserAccount).as_null_object
        UserAccount.stub(:new).and_return(user)
        user.stub(:name).and_return('gwen')
        post :create, user_account: { login: 'gwen' }
        flash[:success].should == "New user account for gwen has been created."
      end


      it "sends a user account registration notification email" do
        UserAccount.stub(:new).and_return(user)
        p user.object_id
        post :create, user_account: { login: 'gwen', email: 'gwen@gmail1.com', email_confirmation: 'gwen@gmail1.com',
          password: 'secret', password_confirmation: 'secret' }
        mail = RegistrationNotifier.deliveries.first
        p mail.to.class
        mail.to.should include('gwen@gmail1.com')
      end


      it "redirects to activation page" do
        user = mock_model(UserAccount).as_null_object
        UserAccount.stub(:new).and_return(user)
        notifier = double('notifier').as_null_object
        RegistrationNotifier.stub(:registered).and_return(notifier)
        post :create, user_account: { login: 'gwen' }
        response.should redirect_to(request_to_activate_path(account_id: user.id))
      end
    end


    context "when user account fails to save" do
      it "renders the new template" do
        user = mock_model(UserAccount).as_null_object
        user.stub(:save).and_return(false)
        post :create, user_account: { id: user.id, login: 'gwen' }
        response.should render_template(:new)
      end
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
