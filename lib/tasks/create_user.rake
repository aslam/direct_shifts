namespace :db do
  desc "Create a user with email and password"
  task create_user: :environment do
    email = ENV['EMAIL']
    password = ENV['PASSWORD']

    if email.nil? || password.nil?
      puts "Please provide EMAIL and PASSWORD environment variables"
      exit 1
    end

    user = User.find_or_initialize_by(email: email)
    user.password = password
    user.password_confirmation = password

    if user.save
      puts "User created with email: #{email}"
    else
      puts "Failed to create user: #{user.errors.full_messages.join(', ')}"
    end
  end
end
