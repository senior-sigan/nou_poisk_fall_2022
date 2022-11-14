if arg[2] == "debug" then require("lldebugger").start() end

function love.load()
    trex = {
        x = 100,
        y = 200,
        speed = 100,
        width = 50,
        height = 80,
        jumping = false,
        yAcc = 0,
        jumpAcc = 10,
    }
end

function love.keypressed(key)
    if key == "space" then
        trex.jumping = true
    end
end

function love.update(dt)

end

function love.draw()
    love.graphics.rectangle("fill", trex.x, trex.y, trex.width, trex.height)
end

while true do
    draw()
end
