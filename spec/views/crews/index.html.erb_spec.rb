require 'spec_helper'

describe "crews/index.html.erb" do
  subject { rendered }
  let(:crews) { [FactoryGirl.create(:crew), FactoryGirl.create(:spies), FactoryGirl.create(:fix_crew)] }
  before do
    Crew.stub(:count).and_return(crews.count)
    assign(:crews, crews)
    render
  end
end
