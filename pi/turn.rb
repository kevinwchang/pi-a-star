require 'response_state'

class Turn < ResponseState::Service
  def initialize(a_star, dir)
    @a_star = a_star
    @dir = dir
  end

  def call(&block)
    case @dir
    when :back
      @a_star.turn_back
    when :right
      @a_star.turn_right
    when :left
      @a_star.turn_left
    when :straight
      # do nothing for straight
    else
      raise "unknown dir: #{@dir}"
    end

    sleep(0.1) # let it start

    until @a_star.get_report.follow_state == 0
      sleep(0.1)
    end

    yield send_state(:done)
  end
end
