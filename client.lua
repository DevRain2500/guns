local arCheckedOut = false
local sgCheckedOut = false
local playerPed = GetPlayerPed(-1)

Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(0, 311) then
            TriggerEvent("ShowInformationLeft", 2000, GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 2.0, GetHashKey("pd11"), 0))
        end
    end
end)


--Get guns via text commands
RegisterCommand("sg", function()
    if not sgCheckedOut then
        if exports.GTALife:countItems("Police Key Card") >= 1 then
            giveWeapon("weapon_pumpshotgun")
            GiveWeaponComponentToPed(playerPed, GetHashKey("weapon_pumpshotgun"), GetHashKey("COMPONENT_AT_AR_FLSH"))
            TriggerEvent("ShowInformationLeft", 2000, "You grabbed your Shotgun...")
            --notify('~g~Received Shotgun.')
            sgCheckedOut = true
        end
    else
        removeWeapon("weapon_pumpshotgun")
        TriggerEvent("ShowInformationLeft", 2000, "You stowed your Shotgun...")
        --notify('~r~Removed shotgun.')
        sgCheckedOut = false
    end
end)

RegisterCommand("ar", function()
    if not arCheckedOut then
        if exports.GTALife:countItems("Police Key Card") >= 1 then
            giveWeapon("weapon_carbinerifle")
            GiveWeaponComponentToPed(playerPed, GetHashKey("weapon_carbinerifle"), GetHashKey("COMPONENT_AT_AR_FLSH"))
            GiveWeaponComponentToPed(playerPed, GetHashKey("weapon_carbinerifle"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
            TriggerEvent("ShowInformationLeft", 2000, "You grabbed your Carbine Rifle...")
            --notify('~g~Received Carbine Rifle.')
            arCheckedOut = true
        end
    else
        removeWeapon("weapon_carbinerifle")
        TriggerEvent("ShowInformationLeft", 2000, "You stowed Carbine Rifle...")
        --notify('~r~Removed Carbine Rifle.')
        arCheckedOut = false
    end
end)

RegisterCommand("remove", function()
    if exports.GTALife:countItems("Police Key Card") >= 1 then
        removeWeapon("weapon_pumpshotgun")
        removeWeapon("weapon_carbinerifle")
        TriggerEvent("ShowInformationLeft", 2000, "You stowed the kitchen sink...")
        notify('~r~Removed Shotgun & Carbine Rifle.')
        sgCheckedOut = false
        arCheckedOut = false
    end
end)
