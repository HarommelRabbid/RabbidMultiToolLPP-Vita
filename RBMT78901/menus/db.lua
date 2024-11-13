local white = Color.new(255, 255, 255)
local blue = Color.new(0, 0, 255)
local hover = 1
local y = 70
local haveMessage = false

local options = {
    {["title"] = "Update Database", ["desc"] = ""},
    {["title"] = "Rebuild Database", ["desc"] = ""},
    {["title"] = "Backup icon layout & app database", ["desc"] = ""},
    {["title"] = "Restore backed up icon layout & app database", ["desc"] = ""},
    {["title"] = "Back", ["desc"] = "Go back"}
}

Controls.setLightbar(0, blue) -- for DS4s only, as a nice touch

-- Main loop
while true do

dofile("scripts/restartcheck.lua")

    -- Checking for message status
    status = System.getMessageState()

--message response checks
              if haveMessage == true then
              if status == FINISHED then
                if hover == 1 then
                 restart_flag = true
                 System.deleteFile("ux0:/id.dat") 
                 System.setMessage("Database updated successfully", false, BUTTON_OK)
                 haveMessage = false
                elseif hover == 2 then
                 restart_flag = true
                 System.deleteFile("ur0:shell/db/app.db") 
                 System.setMessage("Database rebuilded successfully", false, BUTTON_OK)
                 haveMessage = false
                 elseif hover == 3 then
                 System.copyFile("ur0:shell/db/app.db", "ux0:/data/Rabbid MultiTool/Backups/app.db")
                 System.copyFile("ux0:/iconlayout.ini", "ux0:/data/Rabbid MultiTool/Backups/iconlayout.ini")
                 System.setMessage("Backed up successfully", false, BUTTON_OK)
                 haveMessage = false
                 elseif hover == 4 then
                 restart_flag = true
                 System.copyFile("ux0:/data/Rabbid MultiTool/Backups/app.db", "ur0:shell/db/app.db")
                 System.copyFile("ux0:/data/Rabbid MultiTool/Backups/iconlayout.ini", "ux0:/iconlayout.ini")
                 System.setMessage("Backed up successfully", false, BUTTON_OK)
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
            oldpad = pad
            dofile("menus/menu.lua")
        elseif hover == 1 then
            if status ~= RUNNING then
                System.setMessage("Are you sure? After the process is complete, you'll have to reimport your custom themes using a custom theme manager. This is not the case if you only have official themes though.", false, BUTTON_YES_NO)
                haveMessage = true
            end
        elseif hover == 2 then
            if status ~= RUNNING then
                System.setMessage("Are you sure?", false, BUTTON_YES_NO)
                haveMessage = true
            end
            elseif hover == 3 then
                 if status ~= RUNNING then
                  haveMessage = true
                 end
            elseif hover == 4 then
                 if status ~= RUNNING then
                  System.setMessage("Are you sure you want to restore them?", false, BUTTON_YES_NO)
                  haveMessage = true
                 end
        end
    end

    oldpad = pad

    Graphics.termBlend()
    Screen.flip()
    Screen.waitVblankStart()

end
