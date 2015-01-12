
require 'gosu'

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

class Player

  attr_accessor :x, :y, :vel_x, :vel_y, :width, :height, :position_left, :position_right

  def initialize(window)
    @x = @y = @vel_x = @vel_y
    @score = 0
    @screen = window
    @image = Gosu::Image.new(window, "paddle.png", false)
    @height = @image.height
    @width = @image.width
  end

  def position_left
    @x - self.width/2
  end

  def position_right
    @x + self.width/2
  end

  def go_left
    @x -= 5
  end

  def go_right
    @x += 5
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def draw
    @image.draw_rot(@x, @y, 1, 0)
  end
end

class Ball

  attr_accessor :x, :y, :vel_x, :vel_y, :width, :height

  def initialize(window)
    @angle = 0.0
    @vel_x = @vel_y = 5
    @x = @y = 0
    @image = Gosu::Image.new(window, "ball.png", false)
    @height = @image.height
    @width = @image.width
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def move
    @x += @vel_x
    @y += @vel_y
  end

  def y
    @y
  end

  def draw
    @image.draw_rot(@x, @y, 1, 0)
  end

  def collision ball
    if ball.y == 0 and ball.x != 0
      @vel_y *= -1
    else
      @vel_x *= -1
    end
  end

  def player_collision
    @vel_y *= -1
  end
end

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

StartWindow.new.show


