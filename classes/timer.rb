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
      @end - @start
    end
  end

  def draw
    puts @playing_time
    @font.draw(
                "Elapsed playing time: #{@playing_time}",
                (@screen.width/2 - (@font.text_width("Elapsed playing time: #{@playing_time}")/2)),
                100, 0, 1.0, 1.0,
                Gosu::Color::WHITE
              )
  end
end