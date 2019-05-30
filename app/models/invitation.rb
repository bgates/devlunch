class Invitation < ApplicationRecord

  class << self

    def create_from_yelp_data(text, user_id, team_id, user_name)
      parsed_invite = Parser.run(text)
      restaurant = Locator.run(parsed_invite[:place])
      create(parse_yelp_data(restaurant).merge(when: parsed_invite[:time], slack_user_id: user_id, team_id: team_id, user_name: user_name))
    end

    def parse_yelp_data(input)
      addr = input[:location][:display_address]
      address = addr.is_a?(Array) ? addr[0] : addr
      {
        latitude: input[:coordinates][:latitude],
        longitude: input[:coordinates][:longitude],
        where: input[:name],
        image_url: input[:image_url],
        address: address
      }
    end
  end

  def as_json(*)
    super.except("created_at", "updated_at", "user_name").tap do |hash|
      hash["is_today"] = self.when.today?
      hash["time"] = self.when.strftime("%I:%M")
      hash["link"] = "slack://user?team={#{self.team_id}}&id={#{self.user_id}}"
    end
  end
end
