# Eithery Lab, 2016.
# EventType model specs.

require 'rails_helper'

describe EventType do
  subject { FactoryGirl.build :event_type }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has a required unique name'

  it { should respond_to :description }
  it { should respond_to :enabled?, :ordinal }

  context 'when just created' do
    it { is_expected.to be_enabled }
  end
end
