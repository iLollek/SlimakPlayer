-- SlimakPlayer made by iLollek (Original Author)
-- Feel free to use, modify or do whatever with the Code,
-- please just be fair and give Credit.


print([[
        @             _________
         \____       /         \
         /    \     /   ____    \
         \_    \   /   /    \    \
           \    \ (    \__/  )    )
            \    \_\ \______/    /
             \      \           /___
              \______\_________/____"-_
]])

print("SlimakPlayer - Made by iLollek\n")
print("")
os.sleep(0.5)
print("Indexing /disk/")
for i = 1, 20 do
  io.write(".")
  os.sleep(0.2)
end
term.clear()
term.setCursorPos(1, 1)

local function playAudioFile(filename)
    local dfpwm = require("cc.audio.dfpwm")
    local decoder = dfpwm.make_decoder()
    local speaker = peripheral.find("speaker")
  
    for chunk in io.lines(filename, 16 * 32) do
      local buffer = decoder(chunk)
  
      while not speaker.playAudio(buffer) do
        os.pullEvent("speaker_audio_empty")
      end
    end
  end

  local function getMusicFiles()
    local songs = {}
    if fs.exists("/disk/") then
      for _, file in ipairs(fs.find("/disk/*.dfpwm")) do
        table.insert(songs, file)
      end
    end
    return songs
  end
  
-- Function to display song menu and play selected song
local function playSelectedSong(songs)
    term.clear()
    term.setCursorPos(1, 1)
    print("Select a song to play:              Songs Found: "..#songs)
    for i, song in ipairs(songs) do
        term.setCursorPos(1, i + 1)
        if i == 1 then
            io.write("> ")
        else
            io.write("  ")
        end
        print(song)
    end
    local selectedIndex = 1
    while true do
        local event, key = os.pullEvent("key")
        if key == keys.up and selectedIndex > 1 then
            term.setCursorPos(1, selectedIndex + 1)
            io.write("  ")
            term.setCursorPos(1, selectedIndex)
            io.write("> ")
            selectedIndex = selectedIndex - 1
        elseif key == keys.down and selectedIndex < #songs then
            term.setCursorPos(1, selectedIndex + 1)
            io.write("  ")
            term.setCursorPos(1, selectedIndex + 2)
            io.write("> ")
            selectedIndex = selectedIndex + 1
        elseif key == keys.enter then
            term.clear()
            term.setCursorPos(1, 1)
            DisplayTerm = songs[selectedIndex]
            DisplayTerm = string.gsub(DisplayTerm, "disk/", "")
            print("Playing " .. DisplayTerm .. "...")
            parallel.waitForAny(
                function()
                    playAudioFile(songs[selectedIndex])
                end,
                function()
                  local erg = 0.0
                  while true do
                      term.clear()
                      term.setCursorPos(1, 1)
                      print("Playing " .. DisplayTerm .. "...")
                      print("Playing: " .. string.format("%.1f", erg) .. "s")
                      print("\n\n\n\n\n\n\n\n\n\n\n")
                      local numZeroes = math.random(1, 15)
                      for i = 1, numZeroes do
                        io.write("0")
                      end
                      print("")
                      local numZeroes = math.random(1, 15)
                      for i = 1, numZeroes do
                        io.write("0")
                      end
                      print("")
                      local numZeroes = math.random(1, 15)
                      for i = 1, numZeroes do
                        io.write("0")
                      end
                      print("")
                      local numZeroes = math.random(1, 15)
                      for i = 1, numZeroes do
                        io.write("0")
                      end
                      print("")
                      local numZeroes = math.random(1, 15)
                      for i = 1, numZeroes do
                        io.write("0")
                      end
                      os.sleep(0.1)
                      erg = erg + 0.1                
                    end
                end
            )
            break
        end
    end
end

  
  -- Main program loop
  while true do
    local songs = getMusicFiles()
    if #songs == 0 then
      term.clear()
      term.setCursorPos(1, 1)
      print("No songs found on disk or no disk inserted!")
      os.sleep(2)
    else
      playSelectedSong(songs)
    end
  end
  