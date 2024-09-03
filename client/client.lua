local MAX_HEADSHOT_DISTANCE = 180.0

AddEventHandler('gameEventTriggered', function(eventName, data)
    if eventName == 'CEventNetworkEntityDamage' then
        local victim = data[1]
        local attacker = data[2]
        local weaponHash = data[5]
        local isFatal = data[6]

        if IsEntityAPed(victim) and IsEntityAPed(attacker) then
            local victimPlayer = NetworkGetPlayerIndexFromPed(victim)
            local attackerPlayer = NetworkGetPlayerIndexFromPed(attacker)

            if victimPlayer ~= -1 and attackerPlayer ~= -1 then
                local boneIndex = data[4]

                if boneIndex == 31086 then
                    local victimCoords = GetEntityCoords(victim)
                    local attackerCoords = GetEntityCoords(attacker)
                    local distance = #(victimCoords - attackerCoords)

                    if distance > MAX_HEADSHOT_DISTANCE then
                        SetEntityHealth(victim, GetEntityHealth(victim) + GetEntityHealth(attacker) - GetEntityHealth(victim))
                    end
                end
            end
        end
    end
end)
