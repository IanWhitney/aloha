module Aloha
  class SlackUser
    def self.find(client, data)
      u = client.users[data.user]
      if u
        u
      else
        raise "#{client.users.keys}: #{data.user}"
      end
    end
  end
end
