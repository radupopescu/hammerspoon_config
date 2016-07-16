require('window_management')
require('prevent_sleep')

counter = 0

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "T", function()
      hs.notify.new({title="Hammerspoon", informativeText="Hello World" .. counter}):send()
      counter = counter + 1
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
      local laptopScreen = "Color LCD"
      local windowLayout = {
         {"Emacs", nil, laptopScreen, hs.layout.left50, nil, nil},
         {"iTerm2", nil, laptopScreen, hs.layout.right50, nil, nil}
      }
      hs.layout.apply(windowLayout)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
      hs.reload()
      hs.alert.show("Config reloaded")
end)

