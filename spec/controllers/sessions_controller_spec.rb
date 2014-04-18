require 'spec_helper'

shared_examples_for "authentication is failed" do
  specify { should_flash_warning "Invalid login/password combination" }
  it { should render_template(:new) }
end


describe SessionsController do
  let(:remember_token) { SecureRandom.urlsafe_base64 }
  let(:user) { mock_model(UserAccount, login: 'gwen', email: 'gwen@gmail.com',
    password: '123', remember_token: remember_token).as_null_object }

  describe "GET new" do
    it "renders new template" do
      get :new
      response.should render_template(:new)
    end
  end


  describe "POST create" do
    it "finds user account by login" do
      UserAccount.should_receive(:find_by_login).and_return(user)
      post_create
    end

    it "finds user account by email" do
      UserAccount.should_receive(:find_by_email).and_return(user)
      post_create user.email
    end


    context "when user account is found" do
      before { UserAccount.stub(:find_by_login).and_return(user) }

      it "authenticates the user" do
        user.should_receive(:authenticate).with(user.password).and_return(user)
        post_create
      end

      context "and user account was not activated" do
        before { user.stub(:active?).and_return(false) }

        it "displays a flash inactive account warning message" do
          post_create
          should_flash_warning "User account is not activated"
        end

        it "renders new template" do
          post_create
          response.should render_template(:new)
        end
      end

      context "and user is authenticated" do
        before do
          user.stub(:authenticate).and_return(user)
          post_create
        end

        it "signs in user" do
          controller.signed_in?.should be_true
          controller.current_user.should eq(user)
        end

        it { should redirect_to(user_account_path user) }
      end

      context "and user authentication failed" do
        before do
          user.stub(:authenticate).and_return(false)
          post_create
        end

        it_behaves_like "authentication is failed"
      end
    end

    context "when user account is not found" do
      before do
        UserAccount.stub(:find_by_login).and_return(nil)
        post_create
      end

      it_behaves_like "authentication is failed"
    end
  end


  describe "DELETE destroy" do
    before do
      sign_in_user
      delete_destroy
    end

    it "signes the user out" do
      delete_destroy
      controller.signed_in?.should be_false
      controller.current_user.should be_nil
    end

    it { should redirect_to(root_path) }
  end


private
  def post_create(login_or_email=user.login)
    post :create, session: { login: login_or_email, password: user.password, remember_token: remember_token }
  end

  def delete_destroy
    delete :destroy, id: user.id
  end

  def should_flash_warning(message)
    flash[:warning].should == message
  end

  def sign_in_user
    UserAccount.stub(:find_by_login).and_return(user)
    user.stub(:authenticate).and_return(user)
    post_create
  end
end
