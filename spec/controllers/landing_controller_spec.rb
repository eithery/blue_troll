# Eithery Lab, 2016.
# LandingController specs.

require 'rails_helper'

describe LandingController do
  describe 'GET :index' do
    before { get :index }
    it_behaves_like 'it renders HTML teplate', :index
  end
end
