local usbWatcher = hs.usb.watcher.new(function(device)
    -- turn off wifi if usb lan detected
    if device.productID == 33107 then
        if string.find(device.eventType, "added") then
            print('lan connected, disabling wifi')
            hs.wifi.setPower(false)
        elseif string.find(device.eventType, "removed") then
            print('lan disconnected, enabling wifi')
            hs.wifi.setPower(true)
        end
    end
end)
usbWatcher:start()
