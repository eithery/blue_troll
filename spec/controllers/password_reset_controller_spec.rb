require 'spec_helper'

describe PasswordResetController do
  describe "GET new" do
    it "renders new template" do
      get :new
      response.should render_template(:new)
    end
  end


  describe "POST create" do
  end


  describe "GET show" do
  end
end
