module MailerMatchers
  def expect_to_send_email(mailer, options={})
    mailer.deliveries.clear
    expect { yield }.to change { mailer.deliveries.count }
    mail = mailer.deliveries.last
    mail.to.should include(options[:to]) if options[:to]
    mail.subject.should == options[:subject] if options[:subject]
  end


  def email_should_contain(mailer, expected_content)
    mailer.deliveries.clear
    yield if block_given?

    mail = mailer.deliveries.last
    expected_content.each { |part| mail.body.encoded.should =~ part }
  end


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
