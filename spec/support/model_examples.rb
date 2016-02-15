# Eithery Lab, 2016.
# Provides RSpec shared examples.

require 'rails_helper'

shared_examples_for 'a valid domain model' do
  let(:domain_model) { FactoryGirl.build(described_class.to_s.underscore.to_sym) }
  it { expect(domain_model).to be_valid }
end


shared_examples_for 'it has a required unique name' do
  it { should respond_to :name }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should have_db_index(:name).unique }
  it { should validate_length_of(:name).is_at_most 255 }
end


shared_examples_for 'it has timestamps' do
  it { should respond_to :created_at, :created_by }
  it { should respond_to :updated_at, :updated_by }

  it { should validate_presence_of :created_by }
  it { should validate_presence_of :updated_by }
end
