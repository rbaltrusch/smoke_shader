function love.load()
    local shaderCode = love.filesystem.read("smoke_shader.frag")
    shader = love.graphics.newShader(shaderCode)
    shader:send("u_decay_rate", 0.002)
    love.graphics.setBackgroundColor({0, 0, 0, 0})
    screenshot = nil
    colour_decay_rate = 0.95
    shader:send("u_colour_decay_rate", colour_decay_rate)
    transform = love.math.newTransform()
    love.graphics.setShader(shader)
end

function love.keypressed(key)
    if key == "f" then
        love.window.setFullscreen(not love.window.getFullscreen())
    elseif key == "escape" then
        love.event.quit(0)
    elseif key == "q" then
        colour_decay_rate = colour_decay_rate - 0.01
        shader:send("u_colour_decay_rate", colour_decay_rate)
    elseif key == "w" then
        colour_decay_rate = colour_decay_rate + 0.01
        shader:send("u_colour_decay_rate", colour_decay_rate)
    end
end

function love.draw()
    shader:send("u_time", love.timer.getTime())
    if screenshot ~= nil then
        love.graphics.draw(screenshot, transform)
    end
    local x, y = love.mouse.getPosition()
    print(x, y)
    local radius = 5
    love.graphics.setColor(love.math.random(), love.math.random(), love.math.random(), 1)
    love.graphics.circle("fill", x, y, radius)
    screenshot = love.graphics.captureScreenshot(function(image_data) screenshot = love.graphics.newImage(image_data) end)
end
