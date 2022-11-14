local aims = {}
local timer = 0
local cooldown = 1

local WIDTH = 0
local HEIGHT = 0

local IsMouseClicked = false
local WasReleased = true

function love.load()
    HEIGHT = love.graphics.getHeight()
    WIDTH = love.graphics.getWidth()
end

function love.mousepressed(x, y, button)
    IsMouseClicked = true
end

function love.keypressed(key)
    print(key)
    -- if key == 'space'
end

function Aim()
    local w = 50
    local aim = {
        x = love.math.random(0, WIDTH - w),
        y = 0,
        width = w,
        height = 30,
        speed = 150,
        shouldDestroy = false,
    }
    return aim
end

function Collides(rect, point)
    local lx = rect.x
    local rx = rect.x + rect.width
    local ty = rect.y
    local by = rect.y + rect.height

    return point.x >= lx and
        point.x <= rx and
        point.y >= ty and
        point.y <= by
end

function AimUpdate(self, dt)
    self.y = self.y + self.speed * dt

    if IsMouseClicked then
        local point = {
            x = love.mouse.getX(),
            y = love.mouse.getY()
        }
        if Collides(self, point) then
            self.shouldDestroy = true
        end
    end

    if self.y > HEIGHT then
        self.shouldDestroy = true
    end
end

function AimDraw(self)
    love.graphics.rectangle("fill",
        self.x, self.y, self.width, self.height)
end

-- function MouseHandle()
--     IsMouseClicked = false
--     if love.mouse.isDown(1) then
--         if WasReleased then
--             IsMouseClicked = true
--             WasReleased = false
--         end
--     else
--         WasReleased = true
--     end
-- end

function love.update(dt)
    timer = timer - dt
    if timer <= 0 then
        timer = cooldown
        -- timer = (0.5 + love.math.random())
        table.insert(aims, Aim())
    end

    -- MouseHandle()

    for i, a in ipairs(aims) do
        AimUpdate(a, dt)

        if a.shouldDestroy then
            table.remove(aims, i)
        end
    end

    IsMouseClicked = false
end

function love.draw()
    for _, a in ipairs(aims) do
        AimDraw(a)
    end

    if IsMouseClicked then
        love.graphics.print(
            'Click!!!!!!!!', 10, 550)
    end
    love.graphics.print(
        'Aims count ' .. #aims, 10, 560)
    love.graphics.print(
        'Mouse pos ' .. love.mouse.getX() .. ' ' .. love.mouse.getY(), 10, 580)
end
