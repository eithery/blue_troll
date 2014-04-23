module PageExamples
  shared_examples_for "home page" do
    specify { page.should have_title('Blue Troll') }
  end

  shared_examples_for "registration page" do
    specify { page.should have_title('New User Account') }
  end

  shared_examples_for "sign in page" do
    specify { page.should have_title('Sign in') }
  end

  shared_examples_for "activation page" do
    specify { page.should have_title('Account Activation') }
  end
end
