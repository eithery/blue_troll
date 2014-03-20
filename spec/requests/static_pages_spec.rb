require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should be OK" do
      visit root_path
      page.should have_selector('div')
    end
  end
end
