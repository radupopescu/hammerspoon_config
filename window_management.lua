local keys = { move_prefix = {"cmd", "alt"},
               focus_prefix = {"ctrl", "alt"},
               maximize = "[",
               left = "P",
               right = "]",
               top = "-",
               bottom = "'",
               top_left = "0",
               top_right = "=",
               bottom_left = ";",
               bottom_right = "\\",
               focus_west = "H",
               focus_south = "J",
               focus_north = "K",
               focus_east = "L" }


-- No need to edit below this line

local my_grid = hs.grid.setGrid('12x6').setMargins('0,0')

local positions = { left = { hs.geometry.rect(0,0,6,6), hs.geometry.rect(0,0,3,6), hs.geometry.rect(0,0,4,6), hs.geometry.rect(0,0,8,6), hs.geometry.rect(0,0,9,6) },
                    right = { hs.geometry.rect(6,0,6,6), hs.geometry.rect(3,0,9,6), hs.geometry.rect(4,0,8,6), hs.geometry.rect(8,0,4,6), hs.geometry.rect(9,0,3,6) },
                    top = { hs.geometry.rect(0,0,12,3), hs.geometry.rect(0,0,12,2), hs.geometry.rect(0,0,12,4) },
                    bottom = { hs.geometry.rect(0,3,12,3), hs.geometry.rect(0,4,12,2), hs.geometry.rect(0,2,12,4) },
                    tl = { hs.geometry.rect(0,0,6,3), hs.geometry.rect(0,0,6,2), hs.geometry.rect(0,0,6,4),
                           hs.geometry.rect(0,0,4,2), hs.geometry.rect(0,0,4,3), hs.geometry.rect(0,0,4,4),
                           hs.geometry.rect(0,0,8,2), hs.geometry.rect(0,0,8,3), hs.geometry.rect(0,0,8,4) },
                    tr = { hs.geometry.rect(6,0,6,3), hs.geometry.rect(6,0,6,2), hs.geometry.rect(6,0,6,4),
                           hs.geometry.rect(8,0,4,2), hs.geometry.rect(8,0,4,3), hs.geometry.rect(8,0,4,4),
                           hs.geometry.rect(4,0,8,2), hs.geometry.rect(4,0,8,3), hs.geometry.rect(4,0,8,4) },
                    bl = { hs.geometry.rect(0,3,6,3), hs.geometry.rect(0,4,6,2), hs.geometry.rect(0,2,6,4),
                           hs.geometry.rect(0,4,4,2), hs.geometry.rect(0,3,4,3), hs.geometry.rect(0,2,4,4),
                           hs.geometry.rect(0,4,8,2), hs.geometry.rect(0,3,8,3), hs.geometry.rect(0,2,8,4) },
                    br = { hs.geometry.rect(6,3,6,3), hs.geometry.rect(6,4,6,2), hs.geometry.rect(6,2,6,4),
                           hs.geometry.rect(8,4,4,2), hs.geometry.rect(8,3,4,3), hs.geometry.rect(8,2,4,4),
                           hs.geometry.rect(4,4,8,2), hs.geometry.rect(4,3,8,3), hs.geometry.rect(4,2,8,4) } }

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


-- Maximize
local function maximizeHelper()
    my_grid.maximizeWindow(hs.window.focusedWindow())
end

hs.hotkey.bind(keys.move_prefix, keys.maximize, maximizeHelper)
-- Also maximize, since I'm used to this from Caffeine
hs.hotkey.bind(keys.move_prefix, "s", maximizeHelper)

-- Send to left, full height
hs.hotkey.bind(keys.move_prefix, keys.left, positionHelper(positions.left))

-- Send to right, full height
hs.hotkey.bind(keys.move_prefix, keys.right, positionHelper(positions.right))

-- Send to top
hs.hotkey.bind(keys.move_prefix, keys.top, positionHelper(positions.top))

-- Send to bottom
hs.hotkey.bind(keys.move_prefix, keys.bottom, positionHelper(positions.bottom))

-- Send to upper left
hs.hotkey.bind(keys.move_prefix, keys.top_left, positionHelper(positions.tl))

-- Send to upper right
hs.hotkey.bind(keys.move_prefix, keys.top_right, positionHelper(positions.tr))

-- Send to lower left
hs.hotkey.bind(keys.move_prefix, keys.bottom_left, positionHelper(positions.bl))

-- Send to lower right
hs.hotkey.bind(keys.move_prefix, keys.bottom_right, positionHelper(positions.br))


-- Focus
hs.hotkey.bind(keys.focus_prefix, keys.focus_west, function()
    hs.window.filter.focusWest()
end)
hs.hotkey.bind(keys.focus_prefix, keys.focus_east, function()
    hs.window.filter.focusEast()
end)
hs.hotkey.bind(keys.focus_prefix, keys.focus_south, function()
    hs.window.filter.focusSouth()
end)
hs.hotkey.bind(keys.focus_prefix, keys.focus_north, function()
    hs.window.filter.focusNorth()
end)
