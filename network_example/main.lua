local enet = require("enet")

local host
local server

function love.keypressed(btn)
    if btn == 'space' then
        host = enet.host_create('*:5000')
    elseif btn == 's' then
        host = enet.host_create()
        server = host:connect('localhost:5000')
    end
end

function love.update(dt)
    if host then
        local event = host:service()
        while event do
            print(event)
            event = host:service()
        end
    end
end

function love.draw()

end
