require 'spec_helper'

describe StaticPagesController do
  describe "GET home" do
    it "renders a home template" do
      get :home
      response.should render_template(:home)
    end
  end


  describe "GET statistics" do
    it "renders a statistics template" do
      get :statistics
      response.should render_template(:statistics)
    end
  end
end
