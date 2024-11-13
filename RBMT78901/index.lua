if System.doesDirExist("ux0:data/Rabbid MultiTool") == false then
 System.createDirectory("ux0:data/Rabbid MultiTool")
end
if System.isSafeMode() == true then
            if status ~= RUNNING then
System.setMessage("Safe mode was detected, and as a result some parts of the app might not work properly. It's recommended to switch to unsafe mode.", false, BUTTON_OK)
end
end
dofile("menus/menu.lua")