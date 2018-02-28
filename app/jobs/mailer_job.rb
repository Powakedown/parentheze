class MailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "Hey Mailer Job here"
    sleep 1
    puts "ZZZzzz"
    sleep 1
    puts "ZZZzzz"
    sleep 1
    puts "zZZZzzz"
    puts "Awake!"
  end
end
