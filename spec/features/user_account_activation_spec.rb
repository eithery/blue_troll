require 'spec_helper'

describe "User account activation" do
  describe "with correct activation code" do
    before do
      inactive_user = FactoryGirl.create(:inactive_user)
      visit request_to_activate_path
    end
  end


  describe "with incorrect activation code" do
  end


  describe "with correct activation link" do
  end


  describe "with incorrect activation link" do
  end
end
