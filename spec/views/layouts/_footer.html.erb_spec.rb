require 'spec_helper'

describe "layouts/_footer.html.erb" do
  let(:forum_path) { "http://www.nashslet.com/ДоброПожаловать/Форум/tabid/36/language/en-US/Default.aspx" }
  let(:club_path) { "http://bluetrolleyclub.com" }
  subject { rendered }
  before { render }

  it { should have_selector('footer.footer') }
  it { should have_link('About', href: '#') }
  it { should have_link('Contact', href: '#') }
  it { should have_link('Forum', href: forum_path) }
  it { should have_link('Club', href: club_path) }
end
