class AddRecruitsCrew < ActiveRecord::Migration
  def up
    crew = Crew.create!(name: 'Recruits', native_name: 'Новобранцы')

    email = 'alex.shpilsky@avnet.com'
    password = SecureRandom.urlsafe_base64
    user = UserAccount.create!(login: 'ashpilsky', email: email, email_confirmation: email, password: password,
      password_confirmation: password, crew: crew, crew_lead: true, active: true, activated_at: Time.now)
  end


  def down
    user = UserAccount.find_by_login('ashpilsky')
    crew = user.crew
    user.destroy
    crew.destroy
  end
end
