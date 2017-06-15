class Message < ActiveRecord::Base
  has_many :deliveries

  def deliver!(client, user, hook = nil)
    # I don't want to send the first welcome message to everyone already
    #   in the slack. So this is a temporary workaround.
    #
    # If the hook is NewUser and I'm message #1, then send it
    if hook.is_a?(Aloha::Hooks::WelcomeNewUser) && self.id == 1
      if user.ready_for?(self) && !user.received?(self)
        Aloha::Server.say(client, user.username, self.content)
        Delivery.where(message: self, user: user).first_or_create!
      end
    # but if this is not for NewUser, and it's the first welcome, skip it
    #   and mark it as delivered
    elsif self.id == 1
        Delivery.where(message: self, user: user).first_or_create!
    # it's not message 1, so follow normal protocol
    else
      if user.ready_for?(self) && !user.received?(self)
        Aloha::Server.say(client, user.username, self.content)
        Delivery.where(message: self, user: user).first_or_create!
      end
    end
  end
end
