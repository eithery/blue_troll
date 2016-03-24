# Eithery Lab, 2016.
# SessionsHelper specs.

require 'rails_helper'

describe SessionsHelper do
  let(:user) { FactoryGirl.create :user_account }

  describe '#log_in' do
    before { log_in user }

    it { expect(session[:user_id]).to eq user.id }
    it { expect(current_user).to eq user }
  end


  describe '#log_out' do
    before do
      log_in user
      remember user
      log_out
    end

    it { expect(session[:user_id]).to be nil }
    it { expect(cookies.permanent[:remember_token]).to be nil }
    it { expect(current_user).to be nil }
  end


  describe '#remember' do
    before { remember user }

    it { expect(user.remember_token).to_not be_blank }
    it { expect(cookies.permanent[:user_id]).to_not be_blank }
    it { expect(cookies.permanent[:remember_token]).to_not be_blank }
  end


  describe '#forget' do
    before do
      remember user
      forget user
    end

    it { expect(user.remember_token).to be nil }
    it { expect(cookies.permanent[:user_id]).to be nil }
    it { expect(cookies.permanent[:remember_token]).to be nil }
  end


  describe '#current_user?' do
    context 'when user is logged in' do
      let(:other_user) { FactoryGirl.create :user_account }
      before { log_in user }

      it { expect(current_user? user).to be true }
      it { expect(current_user? other_user).to be false }
    end

    context 'when user is not logged in' do
      before { log_out }
      it { expect(current_user? user).to be false }
    end
  end


  describe '#current_user' do
    context 'when user is logged in' do
      before { log_in user }

      it { expect(current_user).to eq user }

      context 'but session is expired' do
        before do
          remember user
          session.delete :user_id
        end
        it { expect(current_user).to eq user }
      end
    end

    context 'when user is not logged in' do
      before { log_out }
      it { expect(current_user).to be nil }
    end
  end


  describe '#logged_in?' do
    context 'when user is logged in' do
      before { log_in user }
      it { expect(logged_in?).to be true }
    end

    context 'when user is not logged in' do
      before { log_out }
      it { expect(logged_in?).to be false }
    end
  end


  describe '#has_validation_errors?' do
    context 'when flash is empty' do
      before { flash.clear }
      it { expect(has_validation_errors?).to be false }
    end

    context 'when flash contains only success messages' do
      before { flash[:success] = "everything OK" }
      it { expect(has_validation_errors?).to be false }
    end

    context 'when flash contains warning messages' do
      before { flash[:warning] = 'account is not activated' }
      it { expect(has_validation_errors?).to be true }
    end

    context 'when flash contains error messages' do
      before { flash[:danger] = 'validation error occurs' }
      it { expect(has_validation_errors?).to be true }
    end
  end


  describe '#flash_error_message' do
    context 'when flash is empty' do
      before { flash.clear }
      it { expect(flash_error_message).to be_blank }
    end

    context 'when flash contains only success messages' do
      before { flash[:success] = "everything OK" }
      it { expect(flash_error_message).to be_blank }
    end

    context 'when flash contains warning messages' do
      before { flash[:warning] = 'Account is not activated' }
      it { expect(flash_error_message).to eq 'Account is not activated' }
    end

    context 'when flash contains error messages' do
      before { flash[:danger] = 'Invalid login/password' }
      it { expect(flash_error_message).to eq 'Invalid login/password' }
    end

    context 'when flash contains multiple error and warning messages' do
      before do
        flash[:danger] = 'Invalid login/password'
        flash[:warning] = 'Account is not activated'
        flash[:danger] = 'Bad thing happens'
      end
      it { expect(flash_error_message).to eq 'Bad thing happens' }
    end
  end


  describe '#animated_form_class' do
    context 'when the form does not contain errors' do
      before { flash.clear }
      it { expect(animated_form_class).to eq 'animated fadeInDown' }
    end

    context 'when the form contains errors messages' do
      before { flash[:danger] = 'Bad thing happens' }
      it { expect(animated_form_class).to be_empty }
    end
  end
end
