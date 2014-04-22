module MailerMatchers
  def expect_to_send_email(mailer, options={})
    mailer.deliveries.clear

    expect { yield }.to change { mailer.deliveries.count }.to(1)

    mail = mailer.deliveries.last
    mail.to.should include(options[:to]) if options[:to]
    mail.subject.should == options[:subject] if options[:subject]
  end
end
