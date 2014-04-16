require 'spec_helper'

describe "layouts/_banner.html.erb" do
  subject { rendered }
  before { render }

  it { should have_selector('div.container') }
  it { should have_selector('img.image-logo') }
end
