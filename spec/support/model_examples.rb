# Eithery Lab, 2016.
# Provides RSpec shared examples.

require 'rails_helper'

shared_examples_for 'a valid domain model' do
  it { is_expected.to be_valid }
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


shared_examples_for 'it performs email format validation' do
  context 'when email has an invalid format' do
    it 'is expected to not be valid' do
      %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo_bar+baz.com].each do |invalid_email|
        email_holder.email = invalid_email
        email_holder.email_confirmation = invalid_email if email_holder.respond_to? :email_confirmation
        expect(email_holder).to_not be_valid
        expect(email_holder).to have(1).error_on :email
      end
    end
  end

  context 'when email has a valid format' do
    it 'is expected to be valid' do
      %w[user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn].each do |valid_email|
        email_holder.email = valid_email
        email_holder.email_confirmation = valid_email if email_holder.respond_to? :email_confirmation
        expect(email_holder).to be_valid
        expect(email_holder).to have(:no).errors
      end
    end
  end
end


shared_examples_for 'it provides statistics' do
  it { should respond_to :adults_total, :adults_paid_total, :adults_onsite_total }
  it { should respond_to :children_total, :children_paid_total, :children_onsite_total }
  it { should respond_to :babies_total, :babies_paid_total, :babies_onsite_total }
  it { should respond_to :participants_total, :participants_paid_total, :participants_onsite_total }
  it { should respond_to :flagged_total, :participants_expected_total }
end
