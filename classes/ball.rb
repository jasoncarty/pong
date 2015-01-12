class Ball

  attr_accessor :x, :y, :vel_x, :vel_y, :width, :height

  def initialize(window)
    @angle = 0.0
    @vel_x = @vel_y = 5
    @x = @y = 0
    @image = Gosu::Image.new(window, "assets/images/ball.png", false)
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