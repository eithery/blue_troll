module UserAccountMacros
  def user
    yield
  end

  def should_be_signed_out
    it { should have_link 'Sign in' }
    it { should_not have_link 'Sign out' }
    it { should_not have_link 'My Profile' }
  end

  def should_be_signed_in
    it { should_not have_link 'Sign in' }
    it { should have_link 'Sign out' }
    it { should have_link 'My Profile' }
  end
end
