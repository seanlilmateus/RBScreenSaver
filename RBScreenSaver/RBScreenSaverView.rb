#
#  RBScreenSaver.rb
#  RBScreenSaver
#
#  Created by Sean Mateus on 26.03.12.
#
framework 'ScreenSaver'
framework 'Cocoa'

class Turtle
  attr_reader :path
  
  def initialize
    @direction = [0, 1]
    @path = NSBezierPath.bezierPath
  end
  
  def stroke
    @path.stroke
  end
  
  def moveToPoint(point)
    @path.moveToPoint(point)
  end
  
  def turn_left
    @direction = case @direction
                  when [0, 1] then [-1,0]
                  when [-1,0] then [0,-1]
                  when [0,-1] then [1, 0]
                  else [0, 1]
                 end
  end
  
  def line_forward(distance)
    @path.relativeLineToPoint([distance * @direction.first, distance * @direction.last])
  end
end

class RBScreenSaverView < ScreenSaverView
  attr_accessor :color, :colors, :count, :origin
  MAX = 20
    
  def initWithFrame(frame, isPreview:preview)
    super(frame, preview)
    @color = 0
    @colors = [NSColor.greenColor, NSColor.redColor, 
               NSColor.blueColor, NSColor.orangeColor, 
               NSColor.yellowColor, NSColor.purpleColor]
    @count = 0
    self.setAnimationTimeInterval(1/30.0)
    self.origin_randomly
    self
  end
  
  def origin_randomly
    rect = self.frame
    @origin = [rect.origin.x + Random.rand(rect.size.width), rect.origin.y + Random.rand(rect.size.height)]
  end
  
  def animateOneFrame
    @count += 1
    if @count == MAX
      @count = 0
      @color += 1
      @color = 0 if @color == @colors.count
      self.origin_randomly
    end
    self.needsDisplay = true
  end
  
  def drawRect(dirty_rect)
    NSColor.blackColor.set
    NSRectFill(dirty_rect)
    @colors[@color].set
    
    turtle = Turtle.new
    turtle.moveToPoint @origin
    (MAX - @count).times do |i|
      turtle.line_forward(5 * i)
      turtle.turn_left
    end
    turtle.stroke
  end
end


