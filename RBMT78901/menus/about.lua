local white = Color.new(255, 255, 255)
local blue = Color.new(0, 0, 255)
local hover = 1
local y = 70

-- Main loop
while true do

dofile("scripts/restartcheck.lua")

    -- Checking for message status
    status = System.getMessageState()

    -- Initializing drawing phase
    Graphics.initBlend()
    Screen.clear()

    Graphics.debugPrint(10, 10, "Rabbid MultiTool LPP-Vita", white)
    Graphics.debugPrint(10, 30, "by Harommel Rabbid", white)

    Graphics.debugPrint(10, 70, "Ver. 0.1", white)
    Graphics.debugPrint(10, 90, "Thanks to the VitaDB discord aswell as Rinnegatamante for help on LPP-Vita :)", white)
    Graphics.debugPrint(10, 130, "Back", blue)

    -- Read controls
    pad = Controls.read()

    if Controls.check(pad, SCE_CTRL_CONFIRM) and not Controls.check(oldpad, SCE_CTRL_CONFIRM) then
    oldpad = pad
            dofile("menus/menu.lua")
    end

    oldpad = pad

    Graphics.termBlend()
    Screen.flip()
    Screen.waitVblankStart()

end
