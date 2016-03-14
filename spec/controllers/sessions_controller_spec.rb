# Eithery Lab, 2016.
# SessionsController specs.

require 'rails_helper'

describe SessionsController do
  describe "GET :new" do
    it "renders 'new' template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
