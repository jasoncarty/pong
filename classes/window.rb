class GameWindow < Gosu::Window

  attr_accessor :screen

  def initialize
    super 640, 480, false
    self.caption = 'Pong'
    @screen = self
    @player = Player.new(self)
    @ball = Ball.new(self)
    @player.warp(320, 460)
    @ball.warp(320, 0)
    @top_limit = 0
    @bottom_limit = 480
    @right_limit = 640
    @left_limit = 0
    @lost = false
  end

  def update
    @ball.move
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.go_left unless @player.position_left == @left_limit
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.go_right unless @player.position_right == @right_limit
    end
    if screen_collision? @ball, @screen
      @ball.collision @ball
    end
    if collision? @ball, @player
      @ball.player_collision
    end
    if @ball.y >= 480
      @lost = true
      StartWindow.new.show
    end
  end

  def draw
    @player.draw
    @ball.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def screen_collision? ball, screen
    if ball.x == @right_limit
      true
    elsif ball.x == @left_limit
      true
    elsif @ball.y == @top_limit
      true
    end
  end

  def collision? obj1, obj2
    if obj1.y == (obj2.y - 10)
      if obj1.x >= obj2.position_left and obj1.x <= obj2.position_right
        true
      end
    else
      false
    end
  end

end