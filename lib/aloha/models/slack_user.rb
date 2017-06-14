module Aloha
  class SlackUser
    def self.find(client, data)
      logger.warn "*" * 10
      logger.warn client.users.keys
      logger.warn data.user_id
      logger.warn "*" * 10
      client.users[data.user_id]
    end
  end
end
