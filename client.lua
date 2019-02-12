local arCheckedOut
local sgCheckedOut
local nearestCar
local playerPed = GetPlayerPed(-1)

local pdModels = {
    "pd1",
    "pd2",
    "pd3",
    "pd4",
    "pd5",
    "pd6",
    "pd7",
    "pd8",
    "pd9",
    "pd10",
    "pd11",
    "pdf350",
    "policet",
    "unmarked1",
    "unmarked2",
    "unmarked3",
    "unmarked4",
}

Citizen.CreateThread(function()
    while true do
        Wait(100)
        arCheckedOut = exports.GTALife:RevoDecorGet(nearestCar, "arEquiped")
        sgCheckedOut = exports.GTALife:RevoDecorGet(nearestCar, "sgEquiped")
        for i=1, #pdModels do
            nearestCar = GetClosestVehicle(GetEntityCoords(playerPed), 2.0, GetHashKey(pdModels[i]), 0)
        end
    end
end)

local function GiveWeapons(weapon)
    if weapon == "sg" then
        giveWeapon("weapon_pumpshotgun")
        GiveWeaponComponentToPed(playerPed, GetHashKey("weapon_pumpshotgun"), GetHashKey("COMPONENT_AT_AR_FLSH"))
        TriggerEvent("ShowInformationLeft", 2000, "You grabbed your Shotgun...")
        --notify('~g~Received Shotgun.')
        sgCheckedOut = exports.GTALife:RevoDecorSet(nearestCar, "sgEquiped", true)
    end
    if weapon == "ar" then
        giveWeapon("weapon_carbinerifle")
        GiveWeaponComponentToPed(playerPed, GetHashKey("weapon_carbinerifle"), GetHashKey("COMPONENT_AT_AR_FLSH"))
        GiveWeaponComponentToPed(playerPed, GetHashKey("weapon_carbinerifle"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
        TriggerEvent("ShowInformationLeft", 2000, "You grabbed your Carbine Rifle...")
        --notify('~g~Received Carbine Rifle.')
        arCheckedOut = exports.GTALife:RevoDecorSet(nearestCar, "arEquiped", true)
    end
end

local function CheckPDVehicle(weapon)
    if IsPedInAnyPoliceVehicle(playerPed) then
        GiveWeapons(weapon)
    end
    if GetVehicleClass(nearestCar) == 18 then
        TriggerEvent("ShowInformationLeft", 2000, "This is emergency")
        TriggerEvent("ShowInformationLeft", 2000, nearestCar)
        GiveWeapons(weapon)
    end
end

--Get guns via text commands
RegisterCommand("sg", function()
    if not sgCheckedOut then
        if exports.GTALife:countItems("Police Key Card") >= 1 then
            CheckPDVehicle("sg")
        else
            TriggerEvent("ShowInformationLeft", 3000, "The gun is locked in place...")
        end
    else
        removeWeapon("weapon_pumpshotgun")
        TriggerEvent("ShowInformationLeft", 2000, "You stowed your Shotgun...")
        --notify('~r~Removed shotgun.')
        sgCheckedOut = exports.GTALife:RevoDecorSet(nearestCar, "sgEquiped", false)
    end
end)

RegisterCommand("ar", function()
    if not arCheckedOut then
        if exports.GTALife:countItems("Police Key Card") >= 1 then
            CheckPDVehicle("ar")
        else
            TriggerEvent("ShowInformationLeft", 3000, "The gun is locked in place...")
        end
    else
        removeWeapon("weapon_carbinerifle")
        TriggerEvent("ShowInformationLeft", 2000, "You stowed your Carbine Rifle...")
        --notify('~r~Removed Carbine Rifle.')
        arCheckedOut = exports.GTALife:RevoDecorSet(nearestCar, "arEquiped", false)
    end
end)

RegisterCommand("remove", function()
    if exports.GTALife:countItems("Police Key Card") >= 1 then
        removeWeapon("weapon_pumpshotgun")
        removeWeapon("weapon_carbinerifle")
        TriggerEvent("ShowInformationLeft", 2000, "You stowed your Shotgun and Carbine...")
        --notify('~r~Removed Shotgun & Carbine Rifle.')
        sgCheckedOut = exports.GTALife:RevoDecorSet(nearestCar, "sgEquiped", false)
        arCheckedOut = exports.GTALife:RevoDecorSet(nearestCar, "arEquiped", false)
    end
end)
