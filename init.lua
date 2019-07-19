hs.application.enableSpotlightForNameSearches(true)

hs.hotkey.bind({'cmd'}, 'escape', function()
  local laptopScreen = hs.screen.primaryScreen()
  local secondScreen = hs.screen{x=1,y=0} or laptopScreen
  local thirdScreen  = hs.screen{x=2,y=0} or secondScreen

  local frame = thirdScreen:frame();

  local windowLayout = {
    {
      'Spotify', nil, thirdScreen, nil,
      thirdScreen:localToAbsolute(hs.geometry{
        0,
        0,
        frame.w,
        frame.h * 0.5
      }), nil
    },
    {
      'Slack', nil, thirdScreen, nil,
      thirdScreen:localToAbsolute(hs.geometry{
        0, frame.h/2,
        frame.w, frame.h/2
      }), nil
    },
    -- {
    --   'iTerm', 'Dev', thirdScreen, nil,
    --   hs.geometry{
    --     frame.x, frame.y, 962.0, 592.0
    --   }
    -- },
    -- {
    --   'OmniFocus', nil, thirdScreen, nil,
    --   hs.geometry{
    --     frame.x, frame.y+frame.h/2,
    --     frame.w/2, frame.h/2
    --   }
    -- }
  }
  hs.layout.apply(windowLayout, string.match)

  for k,v in pairs(windowLayout) do
    hs.application.launchOrFocus(v[1])
  end
end)

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
