# Eithery Lab, 2016.
# Event model specs.

require 'rails_helper'

describe Event do
  it { should respond_to :name }
  it { should respond_to :started_on, :finished_on }
  it { should respond_to :address }
  it { should respond_to :notes }
  it { should respond_to :created_at, :updated_at }

  it { is_expected.to be_valid }

  it { should validate_presence_of :name }
  it { should validate_presence_of :started_on }
  it { should validate_presence_of :finished_on }
  it { should validate_presence_of :address }
end
