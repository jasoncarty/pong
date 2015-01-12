class StartWindow

  def initialize(window)
    @start = false
    @font = Gosu::Font.new(window, Gosu::default_font_name, 20)
    @screen = window
  end

  def draw
    @font.draw(
                "Press any key to play", 
                (@screen.width/2 - (@font.text_width("Press any key to play")/2)),
                (@screen.height/2 - @font.height), 0, 1.0, 1.0, 
                Gosu::Color::WHITE
              )
  end

end