local anim = require('anim')

local scale = 8
love.graphics.setDefaultFilter("nearest", "nearest")
local tiles = love.graphics.newImage('tiles.png')

local playerAnimation = {}

function NewPlayerIdleAnimation()
    local animation = {
        timer = 0,
        speed = 0.2,
        frameIdx = 1,
        frames = {},
    }
    for i = 0, 3 do
        local quad = love.graphics.newQuad(
            128 + i * 16, 100, 16, 28,
            tiles:getWidth(), tiles:getHeight())
        table.insert(animation.frames, quad)
    end
    return animation
end

function NewPlayerRunAnimation()
    local animation = {
        timer = 0,
        speed = 0.1,
        frameIdx = 1,
        frames = {},
    }
    for i = 4, 7 do
        local quad = love.graphics.newQuad(
            128 + i * 16, 100, 16, 28,
            tiles:getWidth(), tiles:getHeight())
        table.insert(animation.frames, quad)
    end
    return animation
end

function love.load()
    playerAnimation.idle = NewPlayerIdleAnimation()
    playerAnimation.run = NewPlayerRunAnimation()

    playerAnimation.current = playerAnimation.idle
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        playerAnimation.current = playerAnimation.run
    else
        playerAnimation.current = playerAnimation.idle
    end

    anim.update(playerAnimation.current, dt)
end

function love.draw()
    local frame = anim.getFrame(playerAnimation.current)
    love.graphics.draw(
        tiles, frame,
        300, 100, 0, scale, scale)
end
