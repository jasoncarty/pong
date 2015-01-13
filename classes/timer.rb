class Timer

  def initialize(window,start)
    @start = start
    @font = Gosu::Font.new(window, Gosu::default_font_name, 20)
    @screen = window
    @playing_time = self.play_time
  end

  def start
    @start
  end

  def end(time)
    @end = time
  end

  def play_time
    if !@end.nil?
      time = (Time.at(@end) - Time.at(@start)).round(2)
    end

  end

  def draw(time)
    @font.draw(
                "Elapsed playing time: #{time} seconds",
                (@screen.width/2 - (@font.text_width("Elapsed playing time: #{time} seconds")/2)),
                100, 0, 1.0, 1.0,
                Gosu::Color::WHITE
              )
  end
end