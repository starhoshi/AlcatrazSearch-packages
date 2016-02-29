require 'bundler/setup'
require 'mail'

class Gmail
  def send(subject, message)
    mail = Mail.new do
      from ENV['EMAIL']
      to ENV['PASSWORD']
      subject subject
      body message
    end

    mail.delivery_method :smtp, {address: 'smtp.gmail.com',
                                 port: 587,
                                 domain: 'smtp.gimal.com',
                                 user_name: ENV['EMAIL'],
                                 password: ENV['PASSWORD']
    }
    mail.deliver!
  end
end

