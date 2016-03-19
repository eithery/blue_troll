# Eithery Lab, 2016.
# ShellController specs.

require 'rails_helper'

describe ShellController do
  describe 'GET :landing' do
    before { get :landing }
    it_behaves_like 'it renders HTML teplate', :landing
  end
end
