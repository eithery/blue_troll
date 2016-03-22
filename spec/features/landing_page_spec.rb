# Eithery Lab, 2016.
# Landing page specs.

require 'rails_helper'

feature 'landing page' do
  subject { page }

  scenario 'user visits Blue Trolley landing page' do
    visit root_path

    is_expected.to have_title 'Blue Trolley | Welcome'
    is_expected.to have_text 'Blue Trolley event is coming'
    is_expected.to have_text 'KOA Campground'
    is_expected.to have_text 'Our Conductors'
    is_expected.to have_text 'Contact Us'
    is_expected.to have_text 'Alex Shaykevich'

    is_expected.to have_link 'Log In', href: login_path
    is_expected.to have_link 'Register', href: signup_path
    is_expected.to have_link 'Send us email', href: 'mailto:bluetrolleyclub@yahoo.com'
    is_expected.to have_link 'Get Google Directions', href: 'https://goo.gl/maps/f6aDsBnDPTT2'
  end
end
