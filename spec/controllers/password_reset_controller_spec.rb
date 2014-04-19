require 'spec_helper'

describe PasswordResetController do
  describe "GET collect_info" do
    it "renders new template" do
      get :collect_info
      response.should render_template(:collect_info)
    end
  end


  describe "POST create" do
  end


  describe "GET show" do
  end
end
