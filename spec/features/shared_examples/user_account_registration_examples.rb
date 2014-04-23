module UserAccountRegistrationExamples
  shared_examples_for "new user account is created" do
    specify { expect { submit_registration_form }.to change{ UserAccount.count }.by(1) }
  end


  shared_examples_for "new user account is not created" do
    specify { expect { submit_registration_form }.not_to change{ UserAccount.count } }
  end
end
