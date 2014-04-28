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

      mail = mailer.deliveries.last
      mail.to.include?(options[:to]).should be_true if options[:to]
      mail.subject.should == options[:subject] if options[:subject]
    end
  end
end
