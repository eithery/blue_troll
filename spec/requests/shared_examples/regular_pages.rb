require 'spec_helper'

shared_examples_for "Page with header" do
  it { should have_link 'Blue Trolley', href: root_path }
  it { should have_link 'Sign in', href: signin_path }
end

shared_examples_for "Page with footer" do
  it { should have_link 'About' }
  it { should have_link 'Contact' }
  it { should have_link 'Forum',
    href: 'http://www.nashslet.com/ДоброПожаловать/Форум/tabid/36/language/en-US/Default.aspx' }
  it { should have_link 'Blue Trolley Club', href: 'http://bluetrolleyclub.com' }
end
