class UserMailer < ApplicationMailer
  def test
    mail = mail subject: 'TEST', to: 'michael@email.com'
    return send_email(mail, 'support@email.com', 'michael@email.com')
  end

  def test2
    mail(to: 'michael@email.com',
         subject: 'TEST2',
         from: 'support@email.com')
  end
end
