sb = {}

function sb:makeRect()
    local frame = hs.screen.mainScreen():frame()
    local w = 900
    local h = 750
    local x = frame.x + (frame.w / 2) - (w / 2)
    local y = frame.y + (frame.h / 2) - (h / 2)
    return hs.geometry.rect(x, y, w, h)
end

function sb:open()
    -- hs.execute('open https://sb.grouchy.cc')
    sb.w:url('https://sb.grouchy.cc')
    sb.w:frame(sb:makeRect())
    sb.w:show()
    sb.w:hswindow():focus()
    print('opened silverbullet')
end

sb.w = (function()
    local rect = sb:makeRect()
    local w = hs.webview.newBrowser()
    w:allowTextEntry(true)
    -- w:allowNewWindows(false)
    w:navigationCallback(function(action, response, newwindow, challenge)
    end)
    return w
end)()

return sb
