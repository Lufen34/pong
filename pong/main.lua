io.stdout:setvbuf('no')

require("utilities")
local bricks = {}
bricks.red = love.graphics.newImage("assets/Bricks_red.png")
bricks.white = love.graphics.newImage("assets/Bricks_white.png")
bricks.sizeX = 80
bricks.sizeY = 40

local balle = {}
balle.x = 0
balle.y = 0
balle.vx = 0
balle.vy = 0
balle.tap = false
balle.img = love.graphics.newImage("assets/ball.png")
balle.sizeX = balle.img:getWidth()
balle.sizeY = balle.img:getHeight()

local pad = {}
pad.x = 0
pad.y = 580
pad.img = love.graphics.newImage("assets/pad.png")
pad.sizeX = pad.img:getWidth()
pad.sizeY = pad.img:getHeight()

local level = {}
level.x = 0
level.y = 0
level.id = 1

speed = 400

function changeMap(id)
    if id == 1 then
      level[1] = "2121212121"
      level[2] = "1212121212"
      level[3] = "2121212121"
      level[4] = "1212121212"
      level[5] = "0000000000"
      level[6] = "0000000000"
      level[7] = "0000000000"
      level[8] = "0000000000"
      level[9] = "0000000000"
      level[10] = "0000000000"
      level[11] = "0000000000"
      level[12] = "0000000000"
      level[13] = "0000000000"
      level[14] = "0000000000"
      level[15] = "0000000000"
      level[16] = "0000000000"
    end 

end

function drawMap(level)
  
  for y = 1, 4 do
    for x = 1, 10 do
      local char = string.sub(level[y], x, x)
      local drawX = (x - 1) * bricks.sizeX
      local drawY = (y - 1) * bricks.sizeY
      if char == '1' then
        love.graphics.draw(bricks.white, drawX, drawY)
      elseif char == '2' then
        love.graphics.draw(bricks.red, drawX, drawY)
      end
    end
  end
end

function start(id)
  changeMap(id)
  balle.tap = true
  
end

function handleInput()
  
  pad.x = love.mouse.getX() - pad.sizeX / 2
  
end

function love.load()
  -- Windows settings
  love.window.setTitle("------ Game made by Lufen ------")
  love.window.setMode(800, 600)
  screenX = love.graphics.getWidth()
  screenY = love.graphics.getHeight()
  
  -- Game settings
  start(level.id)
  
end


function love.update(dt)
  
  handleInput()
  balle.x = balle.x + balle.vx * dt
  balle.y = balle.y + balle.vy * dt
  level.x = math.floor(balle.x / bricks.sizeX) + 1
  level.y = math.floor(balle.y / bricks.sizeY) + 1
  if level.y == 0 then
    level.y = 1 -- Bug Fix Roof ball position in axis
  end

  if level.x >= 1 and level.x <= #level[level.y] and level.y >= 1 and level.y <= 4 then
    local char = string.sub(level[level.y], level.x, level.x)
    if char ~= '0' then
      level[level.y] = replaceAt(level[level.y], level.x, '0')
      balle.vy = 0 - balle.vy 
    end
  end
  if balle.tap == true then
    balle.x = pad.x + pad.sizeX / 2 - balle.sizeX
    balle.y = pad.y - pad.sizeY - balle.sizeY
  end
  
  if balle.x > screenX then
   
   balle.x = screenX
   balle.vx = 0 - balle.vx
    
  end
  
  if balle.y < 0 then
    
    balle.y = 0
    balle.vy = 0 - balle.vy 
    
  end
  
  if balle.x < 0 then
  
    balle.x = 0
    balle.vx = 0 - balle.vx
    
  end
  
  if balle.y > screenY then
    
    balle.tap = true
    
  end
  
  if balle.y + balle.sizeY >= pad.y - pad.sizeY and balle.y + balle.sizeY  < screenY then
    if balle.x > pad.x and balle.x < pad.x + pad.sizeX then
      balle.vy = 0 - balle.vy
    end
  end

end

function love.draw()
  love.graphics.draw(pad.img, pad.x, pad.y)
  love.graphics.draw(balle.img, balle.x, balle.y, 0, 2 ,2)
  drawMap(level)
end

function love.mousepressed(x, y, n)
  if balle.tap == true then
    balle.tap = false
    balle.vx = speed
    balle.vy = -speed
  end
end