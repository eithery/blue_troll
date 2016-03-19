# Eithery Lab, 2016.
# ShellController specs.

require 'rails_helper'

describe ShellController do
  describe 'GET :landing' do
    before { get :landing }

    it { is_expected.to respond_with :ok }
    it { is_expected.to respond_with_content_type :html }
    it { is_expected.to render_with_layout :application }
    it { is_expected.to render_template :landing }
  end
end
