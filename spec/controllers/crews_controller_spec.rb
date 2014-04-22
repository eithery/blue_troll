require 'spec_helper'

describe CrewsController do
  let(:crews) { mock_crews }

  describe "GET index" do
    before { Crew.stub(:order).and_return(crews) }

    it "retrieves all crews in order" do
      Crew.should_receive(:order).with(:name)
      get :index
    end

    it "assigns crews" do
      get :index
      assigns[:crews].should == crews
    end

    it "renders index template" do
      get :index
      response.should render_template(:index)
    end
  end
end
