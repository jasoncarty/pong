class Player

  attr_accessor :x, :y, :vel_x, :vel_y, :width, :height, :position_left, :position_right

  def initialize(window)
    @x = @y = @vel_x = @vel_y
    @score = 0
    @screen = window
    @image = Gosu::Image.new(window, "assets/images/paddle.png", false)
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
    @x -= 5 unless self.position_left == 0
  end

  def go_right
    @x += 5 unless self.position_right == @screen.width
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def draw
    @image.draw_rot(@x, @y, 1, 0)
  end

end
