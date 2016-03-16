# Eithery Lab, 2016.
# RSpec mailer matchers.

module MailerMatchers
  RSpec::Matchers.define :have_subject do |subject|
    match do |mail|
      expect(mail.subject).to eq subject
    end
  end


  RSpec::Matchers.define :be_sent_to do |address|
    match do |mail|
      expect(mail.to).to include address
    end
  end


  RSpec::Matchers.define :be_sent_from do |address|
    match do |mail|
      expect(mail.from).to include address
    end
  end


  RSpec::Matchers.define :send_email do |mailer, options={}|
    match do |action|
      mailer.deliveries.clear
      expect { action.call }.to change { mailer.deliveries.count }
      mailer.deliveries.any? do |mail|
        (options[:to].nil? || mail.to.include?(options[:to])) &&
        (options[:subject].nil? || mail.subject == options[:subject])
      end.should be_true
    end
  end
end
