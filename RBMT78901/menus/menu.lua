local white = Color.new(255, 255, 255)
local blue = Color.new(0, 0, 255)
local hover = 1
local y = 70
local haveMessage = false

local options = {
    {["title"] = "Database Tools", ["desc"] = "Database-related options"},
    {["title"] = "About", ["desc"] = "Credits & info"},
    {["title"] = "Quit", ["desc"] = "Quit and return to the LiveArea"}
}

Controls.setLightbar(0, blue) -- for DS4s only, as a nice touch

-- def confirm button
SCE_CTRL_CONFIRM = Controls.getEnterButton()

-- Main loop
while true do

dofile("scripts/restartcheck.lua")

    -- Checking for message status
    status = System.getMessageState()

if haveMessage == true then
              if status == FINISHED then
                if hover == #options then
                 System.reboot()
                 haveMessage = false
                end
              end
              end
              
              if status == CANCELED then
                 haveMessage = false
              end
              
   -- Initializing drawing phase
    Graphics.initBlend()
    Screen.clear()

    Graphics.debugPrint(10, 10, "Rabbid MultiTool LPP-Vita", white)
    Graphics.debugPrint(10, 30, "by Harommel Rabbid", white)

    for i, option in pairs(options) do
        if i == hover then
            Graphics.debugPrint(10, y - 20 + 20 * i, option.title, blue)
            Graphics.debugPrint(390, 510, option.desc, white)
        else
            Graphics.debugPrint(10, y - 20 + 20 * i, option.title, white)
        end
    end

    -- Read controls
    pad = Controls.read()
    if status ~= RUNNING then
    if Controls.check(pad, SCE_CTRL_UP) and not Controls.check(oldpad, SCE_CTRL_UP) then
        hover = hover - 1
        if hover == 0 then
            hover = #options
        end

    elseif Controls.check(pad, SCE_CTRL_DOWN) and not Controls.check(oldpad, SCE_CTRL_DOWN) then
        hover = hover + 1
        if hover > #options then
            hover = 1
        end
        end
        end

    if Controls.check(pad, SCE_CTRL_CONFIRM) and not Controls.check(oldpad, SCE_CTRL_CONFIRM) then
        if hover == #options then
            if restart_flag == true then
             if status ~= RUNNING then
              System.setMessage("A restart is required, are you sure you want to do that now?", false, BUTTON_YES_NO)
                haveMessage = true
             end
            else
             System.exit()
            end
        elseif hover == 1 then
                oldpad = pad
                dofile("menus/db.lua")
        elseif hover == 2 then
            oldpad = pad
            dofile("menus/about.lua")
        end
    end

    oldpad = pad

    Graphics.termBlend()
    Screen.flip()
    Screen.waitVblankStart()

end
