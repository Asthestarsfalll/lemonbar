local handle = assert(io.popen("read -r a < /tmp/cava.fifo && echo $a | sd '\n' ''", "r"))
local current = assert(handle:read("*a")):gmatch("[^;]+")
handle:close()
local bar = {}
bar[1] = "▁"
bar[2] = "▂"
bar[3] = "▃"
bar[4] = "▄"
bar[5] = "▅"
bar[6] = "▆"
bar[7] = "▇"
bar[8] = "█"
local output = ""
for i in current do
  -- output = output .. bar[i:gsub("\n", "") + 1]
  local index = i:gsub("\n", "")
  if index + 1 < 9 then
    output = output .. bar[index + 1]
  end
end
print(output)
