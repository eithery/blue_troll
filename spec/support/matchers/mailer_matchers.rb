module MailerMatchers
  RSpec::Matchers.define :have_subject do |subject|
    match do |mail|
      mail.subject.should == subject
    end
  end


  RSpec::Matchers.define :be_sent_to do |address|
    match do |mail|
      mail.to.include?(address).should be_true
    end
  end


  RSpec::Matchers.define :be_sent_from do |address|
    match do |mail|
      mail.from.include?(address).should be_true
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
