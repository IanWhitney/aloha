module Aloha
  module Hooks
    class WelcomeNewUser
      def call client, data
        username = Aloha::SlackUser.find(client, data).name
        username = client.users[data.user.id].name
        return if username == client.name
        user_id = client.users[data.user.id].id

        user = User.where(slack_id: user_id).first_or_initialize
        user.username = username
        user.save!

        Aloha::Server.say(client, username, "Welcome to #{client.team.name}!")
        Message.all.each do |message|
          message.deliver!(client, user)
        end
      end
    end
  end
end
