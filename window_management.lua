local keys = { move_prefix = {"cmd", "alt"},
               switch_prefix = {"cmd", "ctrl"},
               maximize = "[",
               left = "P",
               right = "]",
               top = "-",
               bottom = "'",
               top_left = "0",
               top_right = "=",
               bottom_left = ";",
               bottom_right = "\\",
               switcher_next = "J",
               switcher_prev = "K" }

local my_switcher_ui = { textColor = {0.9,0.9,0.9},
                         fontName = 'San Francisco',
                         textSize = 12, -- in screen points
                         highlightColor = {0.8,0.5,0,0.8}, -- highlight color for the selected window
                         backgroundColor = {0.0,0.0,0.0,1},
                         onlyActiveApplication = false, -- only show windows of the active application
                         showTitles = false, -- show window titles
                         titleBackgroundColor = {0,0,0},
                         showThumbnails = true, -- show window thumbnails
                         thumbnailSize = 128, -- size of window thumbnails in screen points
                         showSelectedThumbnail = true, -- show a larger thumbnail for the currently selected window
                         selectedThumbnailSize = 450,
                         showSelectedTitle = true } -- show larger title for the currently selected window


-- No need to edit below this line

local my_grid = hs.grid.setGrid('6x6', 'Color LCD').setMargins('0,0')

local positions = { left = { hs.geometry.rect(0,0,3,6), hs.geometry.rect(0,0,2,6), hs.geometry.rect(0,0,4,6) },
                    right = { hs.geometry.rect(3,0,3,6), hs.geometry.rect(4,0,2,6), hs.geometry.rect(2,0,4,6) },
                    top = { hs.geometry.rect(0,0,6,3), hs.geometry.rect(0,0,6,2), hs.geometry.rect(0,0,6,4) },
                    bottom = { hs.geometry.rect(0,3,6,3), hs.geometry.rect(0,4,6,2), hs.geometry.rect(0,2,6,4) },
                    tl = { hs.geometry.rect(0,0,3,3), hs.geometry.rect(0,0,3,2), hs.geometry.rect(0,0,3,4),
                           hs.geometry.rect(0,0,2,2), hs.geometry.rect(0,0,2,3), hs.geometry.rect(0,0,2,4),
                           hs.geometry.rect(0,0,4,2), hs.geometry.rect(0,0,4,3), hs.geometry.rect(0,0,4,4) },
                    tr = { hs.geometry.rect(3,0,3,3), hs.geometry.rect(3,0,3,2), hs.geometry.rect(3,0,3,4),
                           hs.geometry.rect(4,0,2,2), hs.geometry.rect(4,0,2,3), hs.geometry.rect(4,0,2,4),
                           hs.geometry.rect(2,0,4,2), hs.geometry.rect(2,0,4,3), hs.geometry.rect(2,0,4,4) },
                    bl = { hs.geometry.rect(0,3,3,3), hs.geometry.rect(0,4,3,2), hs.geometry.rect(0,2,3,4),
                           hs.geometry.rect(0,4,2,2), hs.geometry.rect(0,3,2,3), hs.geometry.rect(0,2,2,4),
                           hs.geometry.rect(0,4,4,2), hs.geometry.rect(0,3,4,3), hs.geometry.rect(0,2,4,4) },
                    br = { hs.geometry.rect(3,3,3,3), hs.geometry.rect(3,4,3,2), hs.geometry.rect(3,2,3,4),
                           hs.geometry.rect(4,4,2,2), hs.geometry.rect(4,3,2,3), hs.geometry.rect(4,2,2,4),
                           hs.geometry.rect(2,4,4,2), hs.geometry.rect(2,3,4,3), hs.geometry.rect(2,2,4,4) } }

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
hs.hotkey.bind(keys.move_prefix, "F", maximizeHelper)

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


-- Switcher
local my_switcher = hs.window.switcher.new(nil, my_switcher_ui)

hs.hotkey.bind(keys.switch_prefix, keys.switcher_next, function()
                  my_switcher:next()
end)

hs.hotkey.bind(keys.switch_prefix, keys.switcher_prev, function()
                  my_switcher:previous()
end)
