function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    player = {}
    player.x = love.graphics.getWidth() / 2 - 6 * 5
    player.y = love.graphics.getHeight() / 2 - 9 * 5
    player.speed = 100
    player.sprite = love.graphics.newImage('sprites/player-sheet.png')
    local width = player.sprite:getWidth()
    local height = player.sprite:getHeight() 
    local frame_width = 12
    local frame_height = 18

    player.isMovingDown = false
    player.isMovingUp = false
    player.isMovingLeft = false
    player.isMovingRight = false

    player.animationDown = {}
    player.animationLeft = {}
    player.animationRight = {}
    player.animationUp = {}

    for i=0, 3 do
        table.insert(player.animationDown, love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, width, height))
    end

    for i=0, 3 do
        table.insert(player.animationLeft, love.graphics.newQuad(i * frame_width, frame_height, frame_width, frame_height, width, height))
    end

    for i=0, 3 do
        table.insert(player.animationRight, love.graphics.newQuad(i * frame_width, 2 * frame_height, frame_width, frame_height, width, height))
    end

    for i=0, 3 do
        table.insert(player.animationUp, love.graphics.newQuad(i * frame_width, 3 * frame_height, frame_width, frame_height, width, height))
    end

    currentFrame = 1

    sound = love.audio.newSource('audio/grillos.wav', 'static')
    sound:setLooping(true)
    sound:play()
    
end

function love.update(dt)

    if love.keyboard.isDown('down') then
        currentFrame = currentFrame + 2 * dt
        player.y = player.y + 82 * dt
        player.isMovingDown = true
        player.isMovingLeft, player.isMovingRight, player.isMovingUp = false
    end

    if love.keyboard.isDown('left') then
        currentFrame = currentFrame + 2 * dt
        player.x = player.x - 82 * dt
        player.isMovingLeft = true
        player.isMovingDown, player.isMovingRight, player.isMovingUp = false
    end

    if love.keyboard.isDown('right') then
        currentFrame = currentFrame + 2 * dt
        player.x = player.x + 82 * dt
        player.isMovingRight = true
        player.isMovingDown, player.isMovingLeft, player.isMovingUp = false
    end

    if love.keyboard.isDown('up') then
        currentFrame = currentFrame + 2 * dt
        player.y = player.y - 82 * dt
        player.isMovingUp = true
        player.isMovingDown, player.isMovingLeft, player.isMovingRight = false
    end

    if currentFrame >= 5 then
        currentFrame = 1
    end


    if player.x < 8 then
        player.x = 8
    end

    if player.y < 8 then
        player.y = 8
    end

    if player.x > love.graphics.getWidth() - 10 - 12 * 5 then
        player.x = love.graphics.getWidth() - 10 -12 * 5
    end

    if player.y > love.graphics.getHeight() - 10 - 18 * 5 then
        player.y = love.graphics.getHeight() - 10 - 18 * 5
    end
end

function love.draw()
    love.graphics.draw(player.sprite, player.animationDown[2], player.x, player.y, 0, 5)
    
    if player.isMovingDown then
        love.graphics.draw(player.sprite, player.animationDown[math.floor(currentFrame)], player.x, player.y, 0, 5)
    end

    if player.isMovingLeft then
        love.graphics.draw(player.sprite, player.animationLeft[math.floor(currentFrame)], player.x, player.y, 0, 5)
    end

    if player.isMovingRight then
        love.graphics.draw(player.sprite, player.animationRight[math.floor(currentFrame)], player.x, player.y, 0, 5)
    end

    if player.isMovingUp then
        love.graphics.draw(player.sprite, player.animationUp[math.floor(currentFrame)], player.x, player.y, 0, 5)
    end

    love.graphics.rectangle('line' , 8, 8, love.graphics.getWidth() - 20, love.graphics.getHeight() - 20)
end