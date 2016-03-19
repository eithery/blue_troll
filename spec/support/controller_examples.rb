# Eithery Lab, 2016.
# Provides RSpec shared examples for controllers.

require 'rails_helper'

shared_examples_for 'it renders HTML teplate' do |action|
  it { is_expected.to respond_with :ok }
  it { is_expected.to respond_with_content_type :html }
  it { is_expected.to render_with_layout :application }
  it { is_expected.to render_template action }
end
