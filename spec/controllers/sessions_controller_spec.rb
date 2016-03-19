# Eithery Lab, 2016.
# SessionsController specs.

require 'rails_helper'

shared_examples_for 'it performs correct log in' do
  it { is_expected.to redirect_to user }
  it { expect(logged_in?).to be true }
end


shared_examples_for 'invalid log in operation' do
  it { is_expected.to render_template :new }
  it { is_expected.to set_flash.now[:danger].to(/Invalid login\/password/) }
  it { expect(logged_in?).to be false }
end


describe SessionsController do
  include SessionsHelper

  let(:user) { FactoryGirl.create :user_account, activated: true }

  describe 'GET :new' do
    before { get :new }
    it_behaves_like 'it renders HTML teplate', :new
  end


  describe 'POST :create' do
    context 'when user submits valid credentials' do
      context 'using a valid login' do
        before { post_create user }

        it_behaves_like 'it performs correct log in'
        it { is_expected.to_not set_flash }
      end

      context 'using a valid email address' do
        before { post_create user }

        it_behaves_like 'it performs correct log in'
        it { is_expected.to_not set_flash }
      end

      context 'for not-activated user' do
        before do
          user.activated = false
          user.save!
          post_create user
        end

        it_behaves_like 'it performs correct log in'
        it { is_expected.to set_flash[:warning].to(/User account is not activated/) }
      end
    end

    context 'when user submits invalid credentials' do
      let(:unsigned_user) { FactoryGirl.build :user_account }

      context 'when user is not signed up' do
        before { post_create unsigned_user }
        it_behaves_like 'invalid log in operation'
      end

      context 'when user login is invalid' do
        before { post_create user, login: 'invalid_login' }
        it_behaves_like 'invalid log in operation'
      end

      context 'wnen user email is invalid' do
        before { post_create user, login: 'invalid@gmail.com' }
        it_behaves_like 'invalid log in operation'
      end

      context 'when user password is invalid' do
        before { post_create user, password: 'invalid_password' }
        it_behaves_like 'invalid log in operation'
      end
    end
  end


  describe 'DELETE destroy' do
    context 'when user is logged in' do
      before do
        log_in user
      end

      it { expect { delete :destroy }.to change { logged_in? }.from(true).to(false) }

      it 'redirects to the root' do
        delete :destroy
        is_expected.to redirect_to root_url
      end
    end

    context 'wnen user is NOT logged in' do
      before { delete :destroy }

      it { is_expected.to redirect_to root_url }
      it { expect(logged_in?).to be false }
    end
  end


private
  def post_create(user, login: user.login, password: user.password)
    post :create, params: { session: { login: login, password: password }}
  end
end
