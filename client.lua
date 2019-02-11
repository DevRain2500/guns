--Get guns via text commands
RegisterCommand("sg", function()
  if exports.GTALife:countItems("Police Key Card") == 1 then
    giveWeapon("weapon_pumpshotgun")
    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("weapon_pumpshotgun"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    notify('~g~Received Shotgun.')
  end
end)

RegisterCommand("ar", function()
  if exports.GTALife:countItems("Police Key Card") == 1 then
    giveWeapon("weapon_carbinerifle")
    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("weapon_carbinerifle"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("weapon_carbinerifle"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
    notify('~g~Received Carbine Rifle.')
  end
end)

RegisterCommand("remove", function()
  if exports.GTALife:countItems("Police Key Card") == 1 then
    removeWeapon("weapon_pumpshotgun")
    removeWeapon("weapon_carbinerifle")
    notify('~r~Removed Shotgun & Carbine Rifle.')
end
end)


