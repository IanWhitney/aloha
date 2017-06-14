module Aloha
  module Hooks
    class DeliverMessages
      def call client, data
        return if data.presence != 'active'
        slack_user = Aloha::SlackUser.find(client, data)
        return if slack_user.name == client.name

        user = User.find_by(slack_id: slack_user.id)

        if user
          Message.all.each do |message|
            message.deliver!(client, user)
          end
        end
      end
    end
  end
end
