class GameWindow < Gosu::Window

  attr_accessor :screen

  def initialize
    super 640, 480, false
    self.caption = 'Pong'
    @screen = self
    @start_window = StartWindow.new(self)
    @top_limit = 0
    @bottom_limit = self.height
    @right_limit = self.width
    @left_limit = 0
    @lost = false
  end

  def init
    @timer = Timer.new(self, Time.now)
    @player = Player.new(self)
    @ball = Ball.new(self)
    @player.warp(320, 460)
    @ball.warp(320, 0)
  end

  def update
    if @start_window.nil?
      @ball.move
      player_movements
      check_screen_collision
      check_player_collision
      check_if_lost
    end
  end

  def draw
    if @start_window.nil?
      @ball.draw
      @player.draw
    else
      if @lost
        @timer.draw(@game_duration)
      end
      @start_window.draw
    end
  end

  def button_down(id)
    if !@start_window.nil?
      @start_window = nil
      self.init
    end
    if id == Gosu::KbEscape
      close
    end
  end

  def player_movements
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.go_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.go_right
    end
  end

  def check_screen_collision
    if @ball.x == @right_limit || @ball.x == @left_limit || @ball.y == @top_limit
      @ball.collision(@ball)
    end
  end

  def check_player_collision
    if @ball.y == (@player.y - 10)
      if @ball.x >= @player.position_left and @ball.x <= @player.position_right
        @ball.player_collision
      end
    end
  end

  def check_if_lost
    if @ball.y >= @screen.height
      @lost = true
      @start_window = StartWindow.new(self)
      @ball = player = nil
      @timer.end(Time.now)
      @game_duration = @timer.play_time
      self.init
    end
  end

end