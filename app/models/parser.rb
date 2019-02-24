class Parser
  
  class << self
    def run(string)
      place, time_string = string.split(" at ")
      time = parse_or_default_time(time_string)
      { place: place, time: time }
    end

    def parse_or_default_time(time_string)
      time_string ? Time.parse(time_string) : default_time
    end

    def default_time
      morning?? Time.now.at_noon : Time.now
    end

    def morning?
      Time.now < Time.now.at_noon
    end

  end
end