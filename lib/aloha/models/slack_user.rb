module Aloha
  class SlackUser
    def self.find(client, data)
      raise "#{client.users.keys}: #{data.user}"
      client.users[data.user_id]
    end
  end
end
