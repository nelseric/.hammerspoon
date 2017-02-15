hs.hotkey.bind({'cmd'}, 'escape', function()
  local laptopScreen = hs.screen.primaryScreen()
  local secondScreen = hs.screen{x=1,y=0} or laptopScreen

  local frame = secondScreen:frame();

  local windowLayout = {
    {
      'Spotify', nil, secondScreen, nil,
      secondScreen:localToAbsolute(hs.geometry{
        (frame.w - (frame.w * 0.5)),
        -frame.h,
        frame.w * 0.5,
        frame.h * 0.5
      }), nil},
    {
      'HipChat', nil, secondScreen, nil,
      hs.geometry{
        frame.x + frame.w/2,frame.y+frame.h/2,
        frame.w/2, frame.h/2
      }
    },
  }
  hs.layout.apply(windowLayout)
end)

hs.hotkey.bind({'ctrl'}, 'escape', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
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
