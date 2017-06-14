module Aloha
  class SlackUser
    def self.find(client, data)
      u = client.users[data.user] || client.users[data.user.id]
      if u
        u
      else
        raise "#{client.users.keys}: #{data.user}: #{data.user.class}"
      end
    end
  end
end
