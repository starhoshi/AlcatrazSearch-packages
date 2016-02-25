require 'bundler/setup'
require 'mail'
require 'yaml'

class Gmail
  def send(subject, message)
    config = YAML.load_file("settings.yml")
    mail = Mail.new do
      from config["mail"]["address"]
      to config["mail"]["address"]
      subject subject
      body message
    end

    mail.delivery_method :smtp, {address: 'smtp.gmail.com',
                                 port: 587,
                                 domain: 'smtp.gimal.com',
                                 user_name: config["mail"]["address"],
                                 password: config["mail"]["password"],
    }
    mail.deliver!
  end
end

