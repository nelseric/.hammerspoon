hs.application.enableSpotlightForNameSearches(true)

hs.hotkey.bind({'ctrl'}, 'escape', function()
  local win = hs.window.focusedWindow()
  win:setFrame(win:screen():frame(  ))
end)

hs.hotkey.bind({'ctrl', 'shift'}, '`', function()
  local win = hs.window.focusedWindow()
  win:setFullScreen( not win:isFullscreen())
end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.show("Hammerspoon", "","Config loaded")
