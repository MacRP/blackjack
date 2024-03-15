-- Define the locations of the blackjack tables
local blackjackTables = {
    {pos = vector3(0.0, 0.0, 0.0), heading = 0.0}, -- Add more tables as needed
}

-- Register command to start playing blackjack
RegisterCommand("playblackjack", function(source, args, rawCommand)
    local playerId = source
    local playerPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)

    -- Check if the player is near any blackjack table
    local nearTable = false
    local tableIndex = 0
    for i, table in ipairs(blackjackTables) do
        local distance = #(playerCoords - table.pos)
        if distance < 5.0 then
            nearTable = true
            tableIndex = i
            break
        end
    end

    if nearTable then
        -- Teleport player to the table and set their heading
        SetEntityCoordsNoOffset(playerPed, blackjackTables[tableIndex].pos, 0.0, 0.0, 0.0)
        SetEntityHeading(playerPed, blackjackTables[tableIndex].heading)

        -- Start the blackjack game
        TriggerClientEvent("startBlackjackGame", playerId)
    else
        -- Inform the player that they are not near a blackjack table
        TriggerClientEvent("chatMessage", playerId, "^1You are not near a blackjack table.")
    end
end, false)
