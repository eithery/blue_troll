require 'spec_helper'

describe PasswordResetController do
  describe "GET collect_info" do
    it "renders new template" do
      get :collect_info
      response.should render_template(:collect_info)
    end
  end


  describe "POST send_link" do
    it "finds user by login"
    it "finds user by email"

    context "when login or email exists" do
      it "send email with reset password link"
      it "redirects to change password page"
    end


    context "when login or email cannot be found" do
      it "displays a flash warning message"
      it "renders collect info template"
    end
  end


  describe "GET reset" do
  end
end
