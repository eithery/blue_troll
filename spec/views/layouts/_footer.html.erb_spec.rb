require 'spec_helper'

describe "layouts/_footer.html.erb" do
  subject { rendered }
  before { render }

  it { should have_selector('footer.footer') }
  it { should have_link('About', href: '#') }
  it { should have_link('Contact', href: '#') }
  it { should have_link('Forum', href: forum_url) }
  it { should have_link('Club', href: old_club_url) }
end
