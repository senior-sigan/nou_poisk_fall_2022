local anim = require('anim')

local tiles
local player = {}

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    tiles = love.graphics.newImage("tiles.png")
    player.runAnim = anim.newAnimation({
        frames = {
            { x = 192, y = 132 },
            { x = 192 + 16, y = 132 },
            { x = 192 + 32, y = 132 },
            { x = 192 + 48, y = 132 },
        },
        duration = 0.15,
        frameWidth = 16,
        frameHeight = 32,
        looping = true,
        imageWidth = tiles:getWidth(),
        imageHeight = tiles:getHeight(),
    })
    player.idleAnim = anim.newAnimation({
        frames = {
            { x = 128, y = 132 },
            { x = 128 + 16, y = 132 },
            { x = 128 + 32, y = 132 },
            { x = 128 + 48, y = 132 },
        },
        duration = 0.2,
        frameWidth = 16,
        frameHeight = 28,
        looping = true,
        imageWidth = tiles:getWidth(),
        imageHeight = tiles:getHeight(),
    })
    player.anim = player.idleAnim
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player.anim = player.runAnim
    else
        player.anim = player.idleAnim
    end

    player.anim:update(dt)
end

function love.draw()
    local frame = player.anim:getFrame()
    love.graphics.draw(tiles, frame, 300, 300, 0, 4, 4)
end
