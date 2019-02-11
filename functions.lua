function alert(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(false, state, true, -1)
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(string)
    DrawNotification(true, false)
end

function giveWeapon(weaponHash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weaponHash), --[[ammo]]999, --[[isHidden]]false, --[[equipNow]]true)
end

function removeWeapon(weaponHash)
    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weaponHash))
end