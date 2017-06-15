module Aloha
  module Hooks
    class WelcomeNewUser
      def call client, data
        slack_user = Aloha::SlackUser.find(client, data)

        return if slack_user.name == client.name

        user = User.where(slack_id: slack_user.id).first_or_initialize
        user.username = slack_user.name
        user.save!

        Aloha::Server.say(client, user.username, "Welcome to #{client.team.name}!")
        Message.all.each do |message|
          message.deliver!(client, user, self)
        end
      end
    end
  end
end
