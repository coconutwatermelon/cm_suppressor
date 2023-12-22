CreateThread(function()
    local models = LoadResourceFile(GetCurrentResourceName(), 'models.json')
    
    if models and models ~= '' then
        local data, _, err = json.decode(models)
        if err then
            print("Error decoding JSON: " .. err)
            return
        end

        local vehicleModels = data.vehicleModels
        local pedModels = data.pedModels

        for _, modelName in ipairs(vehicleModels) do
            SetVehicleModelIsSuppressed(GetHashKey(modelName), true)
        end

        for _, modelName in ipairs(pedModels) do
            SetPedModelIsSuppressed(GetHashKey(modelName), true)
        end

        while true do
            Wait(5000)

            local playerPed = PlayerPedId()
            if playerPed then
                local playerLocalisation = GetEntityCoords(playerPed)
                ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)

                local vehicles = GetGamePool("CVehicle")
                local peds = GetGamePool("CPed")

                for i = 1, #vehicles do
                    local vehicle = vehicles[i]
                    if DoesEntityExist(vehicle) then
                        local model = GetEntityModel(vehicle)
                        for _, modelName in ipairs(vehicleModels) do
                            if model == GetHashKey(modelName) then
                                SetEntityAsMissionEntity(vehicle, true, true)
                                DeleteVehicle(vehicle)
                                break
                            end
                        end
                    end
                end

                for i = 1, #peds do
                    local ped = peds[i]
                    if DoesEntityExist(ped) then
                        local model = GetEntityModel(ped)
                        for _, modelName in ipairs(pedModels) do
                            if model == GetHashKey(modelName) then
                                SetEntityAsMissionEntity(ped, true, true)
                                DeletePed(ped)
                                break
                            end
                        end
                    end
                end
            end
        end
    else
        print("Error loading models.json")
        return
    end
end)
