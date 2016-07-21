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

local my_grid = hs.grid.setGrid('6x6', 'Color LCD').setMargins('0,0')

local positions = {
   left33 = hs.geometry.rect(0,0,2,6),
   left50 = hs.geometry.rect(0,0,3,6),
   left66 = hs.geometry.rect(0,0,4,6),
   right33 = hs.geometry.rect(4,0,2,6),
   right50 = hs.geometry.rect(3,0,3,6),
   right66 = hs.geometry.rect(2,0,4,6),
   top33 = hs.geometry.rect(0,0,6,2),
   top50 = hs.geometry.rect(0,0,6,3),
   top66 = hs.geometry.rect(0,0,6,4),
   bottom33 = hs.geometry.rect(0,4,6,2),
   bottom50 = hs.geometry.rect(0,3,6,3),
   bottom66 = hs.geometry.rect(0,2,6,4),
   tl = hs.geometry.rect(0,0,3,3),
   tr = hs.geometry.rect(3,0,3,3),
   bl = hs.geometry.rect(0,3,3,3),
   br = hs.geometry.rect(3,3,3,3)
}

local function areCellsEqual(c1, c2)
   return c1.x == c2.x and c1.y == c2.y and c1.w == c2.w and c1.h == c2.h
end

local function positionHelper(position_list)
   return function()
      local win = hs.window.focusedWindow()

      local num_pos = #position_list
      local pos_curr_idx = 0

      for idx, p in pairs(position_list) do
         local curr_cell = hs.grid.get(win)
         if areCellsEqual(curr_cell, p) then
            pos_curr_idx = idx
         end
      end

      local new_pos = ''
      if pos_curr_idx > 0 and pos_curr_idx < num_pos then
         new_pos = position_list[pos_curr_idx + 1]
      else
         new_pos = position_list[1]
      end

      my_grid.set(win, new_pos)
   end
end

--
--       local num_coeff = #coeff
--       local current_coeff_idx = 0
--       for idx, c in pairs(coeff) do
--          local ex = math.abs(f.x - (max.x + c.x * max.w)) < eps
--          local ey = math.abs(f.y - (max.y + c.y * max.h)) < eps
--          local ew = math.abs(f.w - (c.w * max.w)) < eps
--          local eh = math.abs(f.h - (c.h * max.h)) < eps
--          if ex and ey and ew and eh then
--             current_coeff_idx = idx
--          end
--       end
--
--       local new_coeff = {}
--       if current_coeff_idx > 0 and current_coeff_idx < num_coeff then
--          new_coeff = coeff[current_coeff_idx + 1]
--       else
--          new_coeff = coeff[1]
--       end
--
--       f.x = max.x + new_coeff.x * max.w
--       f.y = max.y + new_coeff.y * max.h
--       f.w = new_coeff.w * max.w
--       f.h = new_coeff.h * max.h
--
--       win:setFrame(f)
--    end
-- end

-- Maximize
local function maximizeHelper()
    my_grid.maximizeWindow(hs.window.focusedWindow())
end

hs.hotkey.bind(keys.prefix, keys.maximize, maximizeHelper)
-- Also maximize, since I'm used to this from Caffeine
hs.hotkey.bind(keys.prefix, "F", maximizeHelper)

-- Send to left, full height
hs.hotkey.bind(keys.prefix, keys.left, positionHelper({positions.left50,
                                                       positions.left33,
                                                       positions.left66}))

-- Send to right, full height
hs.hotkey.bind(keys.prefix, keys.right, positionHelper({positions.right50,
                                                        positions.right33,
                                                        positions.right66}))

-- Send to top
hs.hotkey.bind(keys.prefix, keys.top, positionHelper({positions.top50,
                                                      positions.top33,
                                                      positions.top66}))


-- Send to bottom
hs.hotkey.bind(keys.prefix, keys.bottom, positionHelper({positions.bottom50,
                                                         positions.bottom33,
                                                         positions.bottom66}))

-- Send to upper left
hs.hotkey.bind(keys.prefix, keys.top_left, function()
    my_grid.set(hs.window.focusedWindow(), positions.tl)
end)

-- Send to upper right
hs.hotkey.bind(keys.prefix, keys.top_right, function()
    my_grid.set(hs.window.focusedWindow(), positions.tr)
end)

-- Send to lower left
hs.hotkey.bind(keys.prefix, keys.bottom_left, function()
    my_grid.set(hs.window.focusedWindow(), positions.bl)
end)

-- Send to lower right
hs.hotkey.bind(keys.prefix, keys.bottom_right, function()
    my_grid.set(hs.window.focusedWindow(), positions.br)
end)

