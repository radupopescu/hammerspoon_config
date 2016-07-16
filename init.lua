require('window_management')
require('prevent_sleep')

-- Reload configuration
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    hs.reload()
    hs.notify.new({title="Hammerspoon", informativeText="Config reloaded"}):send()
end)

-- Show Hammerspoon console
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
    hs.openConsole()
end)

