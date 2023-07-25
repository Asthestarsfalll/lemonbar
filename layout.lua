local widgets = require("widgets")

local layout = {
  left = {
    widgets.workspace,
    widgets.memory,
    widgets.cpu,
    widgets.tempture,
    widgets.music,
    widgets.cava,
  },
  right = {
    widgets.battery,
    widgets.date,
    widgets.time,
    widgets.volumebar,
    widgets.wifi,
    widgets.backlight,
    widgets.special,
  },
}

return layout
