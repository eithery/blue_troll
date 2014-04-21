require 'spec_helper'

describe "layouts/application.html.erb" do
  let(:warning) { "Some test warning message" }

  subject { rendered }
  before { render }

  it { should have_title('Blue Troll') }
  it { should have_selector('div.container', minimum: 2) }


  context "without flash messages" do
    it { should_not have_selector('div.alert') }
    it { should_not have_selector('button') }
  end


  context "with flash" do
    before do
      flash[:warning] = warning
      render
    end

    it { should have_selector('div.alert') }
    it { should have_content(warning) }
    it { should have_selector('button.close') }
  end
end
