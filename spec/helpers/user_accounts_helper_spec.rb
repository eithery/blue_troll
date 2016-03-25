# Eithery Lab, 2016.
# UserAccountsHelper specs.

require 'rails_helper'

describe UserAccountsHelper do
  describe '#gravatar_for' do
    let(:user) { mock_model(UserAccount, email: 'gwen@gmail.com').as_null_object }

    it "returns image tag" do
      expect(gravatar_for user).to have_selector 'img'
    end

    it "loads image from gravatar web site" do
      expect(gravatar_for user).to match /http:\/\/www.gravatar.com\/avatar/
    end

    it "uses email to load image" do
      expect(user).to receive(:email).once.and_return('gwen@mail.com')
      gravatar_for user
    end
  end
end
