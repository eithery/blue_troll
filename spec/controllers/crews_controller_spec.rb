# Eithery Lab, 2016.
# CrewsController specs.

require 'rails_helper'

describe CrewsController do
  describe 'GET :index' do
  end


  describe 'GET :show' do
  end


  describe 'GET :new' do
  end


  describe 'POST :create' do
  end


  describe 'GET :edit' do
  end


  describe 'PATCH :update' do
  end


  describe 'DELETE :destroy' do
  end
end


=begin
  describe 'GET #index' do
    context "when user is logged in" do
      with :user
      before { sign_in user }

      describe "controller response and rendered templates" do
        before { get :index }

        it_behaves_like "get OK HTML response"
        it { is_expected.to render_template :index }
      end

      describe "assigned instance variables" do
        let(:crews) { mock_crews }
        before do
          controller.stub(:all_crews).and_return(crews)
          get :index
        end
        it { expect(assigns(:crews)).to eq(crews) }
      end

      describe "model operations" do
        it "retrieves all crews" do
          is_expected.to receive(:all_crews).once
          get :index
        end
      end
    end

    context "when user is logged out" do
      before { get :index }

      it { is_expected.to redirect_to signin_path }
    end
  end


  describe 'GET #show' do
    context "when priveleged user is logged in" do
      with :gwen
      with :financier
      before { sign_in financier }

      describe "controller response and rendered templates" do
        before { get :show, id: gwen.crew }

        it_behaves_like "get OK HTML response"
        it { is_expected.to render_template :show }
      end
    end

    context "when regular user (crew member) is logged in" do
      with :morfey
      before do
        sign_in morfey.user_account
        get :show, id: morfey.crew
      end

      it { is_expected.to redirect_to root_path }
    end

    context "when crew lead of this crew is logged in" do
      with :gwen
      before do
        sign_in gwen.user_account
        get :show, id: gwen.crew
      end

      it_behaves_like "get OK HTML response"
      it { is_expected.to render_template :show }
    end

    context "when other crew lead is logged in" do
      with :gwen_crew
      with :crew_lead
      before do
        sign_in crew_lead
        get :show, id: gwen_crew
      end

      it { is_expected.to redirect_to root_path }
    end

    context "when user is logged out" do
      with :gwen_crew
      before { get :show, id: gwen_crew }

      it { is_expected.to redirect_to signin_path }
    end
  end

private

  def sign_in(user)
    cookies[:remember_token] = user.remember_token
  end
end
=end