local keys = {
   prefix = {"cmd", "alt"},
   maximize = "[",
   left = "P",
   right = "]",
   top = "-",
   bottom = "'",
   top_left = "0",
   top_right = "=",
   bottom_left = ";",
   bottom_right = "\\"
}

-- No need to edit below this line

local eps = 10

local function makeSetFrameCallback(coeff)
   return function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      f.x = max.x + coeff.x * max.w
      f.y = max.y + coeff.y * max.h
      f.w = coeff.w * max.w
      f.h = coeff.h * max.h

      win:setFrame(f)
   end
end

local function makeSetFrameCallback2(coeff)
   return function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      local num_coeff = #coeff
      local current_coeff_idx = 0
      for idx, c in pairs(coeff) do
         local ex = math.abs(f.x - (max.x + c.x * max.w)) < eps
         local ey = math.abs(f.y - (max.y + c.y * max.h)) < eps
         local ew = math.abs(f.w - (c.w * max.w)) < eps
         local eh = math.abs(f.h - (c.h * max.h)) < eps
         if ex and ey and ew and eh then
            current_coeff_idx = idx
         end
      end

      local new_coeff = {}
      if current_coeff_idx > 0 and current_coeff_idx < num_coeff then
         new_coeff = coeff[current_coeff_idx + 1]
      else
         new_coeff = coeff[1]
      end

      f.x = max.x + math.abs(new_coeff.x * max.w)
      f.y = max.y + math.abs(new_coeff.y * max.h)
      f.w = new_coeff.w * max.w
      f.h = new_coeff.h * max.h

      win:setFrame(f)
   end
end

-- Maximize
hs.hotkey.bind(keys.prefix, keys.maximize, makeSetFrameCallback(hs.layout.maximized))

-- Send to left, full height
hs.hotkey.bind(keys.prefix, keys.left, makeSetFrameCallback2({
                     {x = 0, y = 0, w = 0.5, h = 1},
                     {x = 0, y = 0, w = 0.33333, h = 1},
                     {x = 0, y = 0, w = 0.66666, h = 1}}))

-- Send to right, full height
hs.hotkey.bind(keys.prefix, keys.right, makeSetFrameCallback2({
                     {x = 0.5, y = 0, w = 0.5, h = 1},
                     {x = 0.66666, y = 0, w = 0.33333, h = 1},
                     {x = 0.33333, y = 0, w = 0.66666, h = 1}}))

-- Send to top half
hs.hotkey.bind(keys.prefix, keys.top, makeSetFrameCallback2({
                     {x = 0, y = 0, w = 1, h = 0.5},
                     {x = 0, y = 0, w = 1, h = 0.33333},
                     {x = 0, y = 0, w = 1, h = 0.66666}}))

-- Send to bottom half
hs.hotkey.bind(keys.prefix, keys.bottom, makeSetFrameCallback2({
                     {x = 0, y = 0.5, w = 1, h = 0.5},
                     {x = 0, y = 0.66666, w = 1, h = 0.33333},
                     {x = 0, y = 0.33333, w = 1, h = 0.66666}}))

-- Send to upper left
hs.hotkey.bind(keys.prefix, keys.top_left, makeSetFrameCallback({x = 0, y = 0, w = 0.5, h = 0.5}))

-- Send to upper right
hs.hotkey.bind(keys.prefix, keys.top_right, makeSetFrameCallback({x = 0.5, y = 0, w = 0.5, h = 0.5}))

-- Send to lower left
hs.hotkey.bind(keys.prefix, keys.bottom_left, makeSetFrameCallback({x = 0, y = 0.5, w = 0.5, h = 0.5}))

-- Send to lower right
hs.hotkey.bind(keys.prefix, keys.bottom_right, makeSetFrameCallback({x = 0.5, y = 0.5, w = 0.5, h = 0.5}))

