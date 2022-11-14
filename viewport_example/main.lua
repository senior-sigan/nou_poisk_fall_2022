local viewport = { x = 0, y = 0, width = 800, height = 600 }
local player = { speed = 300, x = 50, y = 60, width = 30, height = 40 }
local circles = {
    { x = 10, y = 20, radius = 30 },
    { x = 500, y = 400, radius = 30 },
    { x = 1000, y = 300, radius = 30 },
    { x = 300, y = 800, radius = 30 },
}

function love.load()
    viewport.x = player.x - love.graphics.getWidth() / 2
    viewport.y = player.y - love.graphics.getHeight() / 2
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player.y = player.y - player.speed * dt
        viewport.y = viewport.y - player.speed * dt
    elseif love.keyboard.isDown('s') then
        player.y = player.y + player.speed * dt
        viewport.y = viewport.y + player.speed * dt
    elseif love.keyboard.isDown('a') then
        player.x = player.x - player.speed * dt
        viewport.x = viewport.x - player.speed * dt
    elseif love.keyboard.isDown('d') then
        player.x = player.x + player.speed * dt
        viewport.x = viewport.x + player.speed * dt
    end
end

function love.draw()
    love.graphics.rectangle('fill',
        player.x - viewport.x,
        player.y - viewport.y,
        player.width, player.height)
    for i, circle in ipairs(circles) do
        love.graphics.circle('fill',
            circle.x - viewport.x,
            circle.y - viewport.y,
            circle.radius)
    end
end
