class ApplicationMailer < ActionMailer::Base
  require 'sendgrid-ruby'
  include SendGrid

  default from: 'support@email.com'
  layout 'mailer'

  private

  def send_email(mail, from, to, attachment = nil)
    sg_mail = Mail.new
    sg_mail.from = Email.new(email: from)
    sg_mail.subject = mail.subject
    sg_mail.add_content(Content.new(type: 'text/html', value: mail.body.encoded))
    personalization = Personalization.new
    personalization.add_to(Email.new(email: to, name: 'Tester'))
    sg_mail.add_personalization(personalization)
    if attachment
      att = Attachment.new
      att.content = attachment[:content]
      att.type = attachment[:type]
      att.filename = attachment[:filename]
      att.disposition = attachment[:disposition]
      att.content_id = attachment[:content_id]
      sg_mail.add_attachment(att)
    end
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: sg_mail.to_json)
  end

end
