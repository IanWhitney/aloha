module Aloha
  class SlackUser
    def self.find(client, data)
      client.users[data.user_id]
    end
  end
end
