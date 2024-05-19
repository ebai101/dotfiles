crosshair = {}

crosshair.menubar = hs.menubar.new(true, 'crosshair')
crosshair.menubar:setTitle('xh')
crosshair.menubar:setMenu({
    {
        title = 'dot',
        fn = function()
            crosshair:show('crosshairs/dot.png')
        end
    },
    {
        title = 'cross',
        fn = function()
            crosshair:show('crosshairs/cross.png')
        end
    },
    {
        title = 'bigcross',
        fn = function()
            crosshair:show('crosshairs/bigcross.png', 0, -11)
        end
    },
    {
        title = 'hide',
        fn = function()
            crosshair:hide()
        end
    }
})

function crosshair:show(filename, xOffset, yOffset)
    -- crosshair images are from https://crosshair.themeta.gg/
    xOffset = xOffset or 0
    yOffset = yOffset or 19
    crosshair:hide()
    local frame = hs.screen.primaryScreen():frame()
    local img = hs.image.imageFromPath(filename):size()
    local x = frame.x + (frame.w / 2) - ((img.w / 2) + xOffset)
    local y = frame.y + (frame.h / 2) - ((img.h / 2) + yOffset)
    crosshair.image = hs.drawing.image(hs.geometry.rect(x, y, img.w, img.h), filename)
    crosshair.image:show()
    print('showed ' .. filename)
end

function crosshair:hide()
    if crosshair.image then
        crosshair.image:hide()
    end
    print('hid crosshair')
end

return crosshair
