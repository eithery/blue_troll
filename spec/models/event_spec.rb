# Eithery Lab, 2016.
# Event model specs.

require 'rails_helper'

describe Event do
  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has a required unique name'
  it_behaves_like 'it has timestamps'

  it { should respond_to :started_on, :finished_on }
  it { should respond_to :address }
  it { should respond_to :notes }

  it { should validate_presence_of :started_on }
  it { should validate_presence_of :finished_on }
  it { should validate_presence_of :address }
end
