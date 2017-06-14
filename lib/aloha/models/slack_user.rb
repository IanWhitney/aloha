module Aloha
  class SlackUser
    def self.find(client, data)
      raise "#{client.users.keys}: #{client.user}"
      client.users[data.user_id]
    end
  end
end
