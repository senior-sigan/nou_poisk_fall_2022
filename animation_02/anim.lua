local Animation = {}

function Animation:update(dt)
    self.timer = self.timer + dt
    if self.timer >= self.duration then
        self.timer = self.timer - self.duration
        local n = #self.frames
        if self.position == n and not self.looping then
            self.finished = true
            return
        end
        self.position = self.position % n + 1
    end
end

function Animation:getFrame()
    local frame = self.frames[self.position]
    local quad = love.graphics.newQuad(
        frame.x,
        frame.y,
        self.frameWidth,
        self.frameHeight,
        self.imageWidth,
        self.imageHeight
    )
    return quad
end

function Animation:reset()
    self.position = 1
    self.finished = false
    self.timer = 0
end

local function newAnimation(o)
    return setmetatable({
        frames = o.frames,
        duration = o.duration,
        imageWidth = o.imageWidth,
        imageHeight = o.imageHeight,
        frameWidth = o.frameWidth,
        frameHeight = o.frameHeight,
        looping = o.looping,
        --- private
        timer = 0,
        position = 1,
        finished = false,
    }, {
        __index = Animation
    })
end

return {
    newAnimation = newAnimation,
}
