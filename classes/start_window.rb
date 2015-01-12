class StartWindow < Gosu::Window

  def initialize
    super 640, 480, false
    @start = false
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    if button_down? Gosu::KbEscape then
      close
    end
    if button_down? Gosu::KbRight then

      window = GameWindow.new.show
      close
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      #close
    else
      #window = GameWindow.new.show
      #close
      #puts self.methods
    end
  end

  def draw
    @font.draw("Press any key to play", 10, 10, 0, 1.0, 1.0, Gosu::Color::WHITE)
  end

end