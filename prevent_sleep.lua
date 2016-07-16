local menubar = hs.menubar.new()

local iconSize = 20

local icons = {
   empty = hs.image.imageFromPath("cup.pdf"):setSize({w = iconSize, h = iconSize}),
   full = hs.image.imageFromPath("cup_full.pdf"):setSize({w = iconSize, h = iconSize})
}

local function setState(state)
   if state then
      menubar:setIcon(icons.full)
      hs.notify.new({title="Hammerspoon", informativeText="Sleep inhibited"}):send()
   else
      menubar:setIcon(icons.empty)
      hs.notify.new({title="Hammerspoon", informativeText="Sleep allowed"}):send()
   end
end

local function clickedHandler()
   setState(hs.caffeinate.toggle("displayIdle"))
end

if menubar then
    menubar:setClickCallback(clickedHandler)
    setState(hs.caffeinate.get("displayIdle"))
end
