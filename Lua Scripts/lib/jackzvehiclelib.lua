local vehiclelib = {
    MAX_EXTRAS = 14,
    FORMAT_VERSION = "JSTAND 1.3.1",
    LIB_VERSION = "1.1.2",
    MOD_NAMES = {
        [1] = "Spoilers",
        [2] = "Front Bumper",
        [3] = "Rear Bumper",
        [4] = "Side Skirt",
        [5] = "Exhaust",
        [6] = "Frame",
        [7] = "Grille",
        [8] = "Hood",
        [9] = "Fender",
        [10] = "Right Fender",
        [11] = "Roof",
        [12] = "Engine",
        [13] = "Brakes",
        [14] = "Transmission",
        [15] = "Horns",
        [16] = "Suspension",
        [17] = "Armor",
        [24] = "Wheels Design",
        [25] = "Motorcycle Back Wheel Design",
        [26] = "Plate Holders",
        [28] = "Trim Design",
        [29] = "Ornaments",
        [31] = "Dial Design",
        [34] = "Steering Wheel",
        [35] = "Shifter Leavers",
        [36] = "Plaques",
        [39] = "Hydraulics",
        [49] = "Livery"
    },
    -- Subtract index by 1 to get modType (ty lua)
    TOGGLEABLE_MOD_NAMES = {
        [18] = "UNK17",
        [19] = "Turbo Turning",
        [20] = "UNK19",
        [21] = "Tire Smoke",
        [22] = "UNK21",
        [23] = "Xenon Headlights"
    },
    VEHICLE_TYPES = {
        "Compacts",
        "Sedans",
        "SUVs",
        "Coupes",
        "Muscle",
        "Sports Classics",
        "Sports",
        "Super",
        "Motorcycles",
        "Off-road",
        "Industrial",
        "Utility",
        "Vans",
        "Cycles",
        "Boats",
        "Helicopters",
        "Planes",
        "Service",
        "Emergency",
        "Military",
        "Commercial",
        "Trains"
    }
}
function vehiclelib.Serialize(vehicle)
    local model = ENTITY.GET_ENTITY_MODEL(vehicle)
    local Primary = {
        Custom = VEHICLE.GET_IS_VEHICLE_PRIMARY_COLOUR_CUSTOM(vehicle),
    }
    local Secondary = {
        Custom = VEHICLE.GET_IS_VEHICLE_SECONDARY_COLOUR_CUSTOM(vehicle),
    }
    -- Declare pointers
    local Color = {
        r = memory.alloc(4),
        g = memory.alloc(4),
        b = memory.alloc(4),
    }

    if Primary.Custom then
        VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, Color.r, Color.g, Color.b)
        Primary["Custom Color"] = {
            r = memory.read_int(Color.r),
            b = memory.read_int(Color.g),
            g = memory.read_int(Color.b)
        }
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_1(vehicle, Color.r, Color.b, Color.g)
        Primary["Paint Type"] = memory.read_int(Color.r)
        Primary["Color"] = memory.read_int(Color.g)
        Primary["Pearlescent Color"] = memory.read_int(Color.b)
    end
    if Secondary.Custom then
        VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, Color.r, Color.g, Color.b)
        Secondary["Custom Color"] = {
            r = memory.read_int(Color.r),
            b = memory.read_int(Color.g),
            g = memory.read_int(Color.b)
        }
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_2(vehicle, Color.r, Color.b)
        Secondary["Paint Type"] = memory.read_int(Color.r)
        Secondary["Color"] = memory.read_int(Color.g)
    end
    VEHICLE.GET_VEHICLE_EXTRA_COLOURS(vehicle, Color.r, Color.g)
    local ColorExtras = {
        pearlescent = memory.read_int(Color.r),
        wheel = memory.read_int(Color.g),
    }

    VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, Color.r, Color.g, Color.b)
    local TireSmoke = {
        r = memory.read_int(Color.r),
        g = memory.read_int(Color.g),
        b = memory.read_int(Color.b),
    }

    VEHICLE._GET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, Color.r, Color.g, Color.b)
    local Neon = {
        Color = {
            r = memory.read_int(Color.r),
            g = memory.read_int(Color.g),
            b = memory.read_int(Color.b),
        },
        Left = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 0),
        Right = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 1),
        Front = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 2),
        Back = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 3),
    }
    VEHICLE._GET_VEHICLE_DASHBOARD_COLOR(vehicle, Color.r)
    VEHICLE._GET_VEHICLE_INTERIOR_COLOR(vehicle, Color.b)
    local DashboardColor = memory.read_int(Color.r)
    local InteriorColor = memory.read_int(Color.b)
    VEHICLE.GET_VEHICLE_COLOR(vehicle, Color.r, Color.g, Color.b)
    local Vehicle = {
        r = memory.read_int(Color.r),
        g = memory.read_int(Color.g),
        b = memory.read_int(Color.b),
    }
    VEHICLE.GET_VEHICLE_COLOURS(vehicle, Color.r, Color.g)
    Vehicle["Primary"] = memory.read_int(Color.r)
    Vehicle["Secondary"] = memory.read_int(Color.g)
    memory.free(Color.r)
    memory.free(Color.g)
    memory.free(Color.b)
    local Extras = {}
    for x = 0, vehiclelib.MAX_EXTRAS do
        if VEHICLE.DOES_EXTRA_EXIST(vehicle, x) then
            Extras[tostring(x)] = VEHICLE.IS_VEHICLE_EXTRA_TURNED_ON(vehicle, x)
        end
    end
    local mods = { Toggles = {} }
    for i, modName in pairs(vehiclelib.MOD_NAMES) do
        mods[modName] = VEHICLE.GET_VEHICLE_MOD(vehicle, i - 1)
    end
    for i, mod in pairs(vehiclelib.TOGGLEABLE_MOD_NAMES) do
        mods.Toggles[mod] = VEHICLE.IS_TOGGLE_MOD_ON(vehicle, i - 1)
    end
    local saveData = {
        Format = vehiclelib.FORMAT_VERSION,
        Model = model,
        Name = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(model),
        Manufacturer = VEHICLE._GET_MAKE_NAME_FROM_VEHICLE_MODEL(model),
        Type = vehiclelib.VEHICLE_TYPES[VEHICLE.GET_VEHICLE_CLASS(vehicle)],
        ["Tire Smoke"] = TireSmoke,
        Livery = {
            Style = VEHICLE.GET_VEHICLE_LIVERY(vehicle),
            Count = VEHICLE.GET_VEHICLE_LIVERY_COUNT(vehicle)
        },
        ["License Plate"] = {
            Text = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle),
            Type = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle)
        },
        ["Window Tint"] = VEHICLE.GET_VEHICLE_WINDOW_TINT(vehicle),
        Colors = {
            Primary = Primary,
            Secondary = Secondary,
            ["Color Combo"] = VEHICLE.GET_VEHICLE_COLOUR_COMBINATION(vehicle),
            ["Paint Fade"] = VEHICLE.GET_VEHICLE_ENVEFF_SCALE(vehicle),
            Vehicle = Vehicle,
            Extras = ColorExtras
        },
        Lights = {
            ["Xenon Color"] = VEHICLE._GET_VEHICLE_XENON_LIGHTS_COLOR(vehicle),
            Neon = Neon
        },
        ["Engine Running"] = VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(vehicle),
        ["Dashboard Color"] = DashboardColor,
        ["Interior Color"] = InteriorColor,
        ["Dirt Level"] = VEHICLE.GET_VEHICLE_DIRT_LEVEL(vehicle),
        ["Bulletproof Tires"] = VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle),
        Mods = mods,
        Extras = Extras
    }

    return saveData
end
function vehiclelib.ApplyToVehicle(vehicle, saveData)
    -- Vehicle Paint Colors. Not sure if all these are needed but well I store them
    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    VEHICLE.SET_VEHICLE_COLOUR_COMBINATION(vehicle, saveData.Colors["Color Combo"] or -1)
    if saveData.Colors.Extra then
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, saveData.Colors.Extras.pearlescent, saveData.Colors.Extras.wheel)
    end
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, saveData.Colors.Vehicle.r, saveData.Colors.Vehicle.g, saveData.Colors.Vehicle.b)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, saveData.Colors.Vehicle.r, saveData.Colors.Vehicle.g, saveData.Colors.Vehicle.b)
    VEHICLE.SET_VEHICLE_COLOURS(vehicle, saveData.Colors.Vehicle.Primary or 0, saveData.Colors.Vehicle.Secondary or 0)
    if saveData.Colors.Primary.Custom and saveData.Colors.Primary["Custom Color"] then
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, saveData.Colors.Primary["Custom Color"].r, saveData.Colors.Primary["Custom Color"].b, saveData.Colors.Primary["Custom Color"].g)
    else
        VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, saveData.Colors.Primary["Paint Type"], saveData.Colors.Primary.Color, saveData.Colors.Primary["Pearlescent Color"])
    end
    if saveData.Colors.Secondary.Custom and saveData.Colors.Secondary["Custom Color"] then
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, saveData.Colors.Secondary["Custom Color"].r,  saveData.Colors.Secondary["Custom Color"].b, saveData.Colors.Secondary["Custom Color"].g)
    else
        VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, saveData.Colors.Secondary["Paint Type"], saveData.Colors.Secondary.Color)
    end
    VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, saveData["Colors"]["Paint Fade"] or 0)
    -- Misc Colors / Looks
    if saveData["Tire Smoke"] then
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, saveData["Tire Smoke"].r or 255, saveData["Tire Smoke"].g or 255, saveData["Tire Smoke"].b or 255)
    end
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, saveData["Bulletproof Tires"] or false)
    VEHICLE._SET_VEHICLE_DASHBOARD_COLOR(vehicle, saveData["Dashboard Color"] or -1)
    VEHICLE._SET_VEHICLE_INTERIOR_COLOR(vehicle, saveData["Interior Color"] or -1)
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, saveData["Dirt Level"] or 0.0)

    -- Lights
    VEHICLE._SET_VEHICLE_XENON_LIGHTS_COLOR(vehicle, saveData["Lights"]["Xenon Color"] or 255)
    VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, saveData.Lights.Neon.Color.r or 255, saveData.Lights.Neon.Color.g or 255, saveData.Lights.Neon.Color.b or 255)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 0, saveData.Lights.Neon.Left or false)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 1, saveData.Lights.Neon.Right or false)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 2, saveData.Lights.Neon.Front or false)
    VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 3, saveData.Lights.Neon.Back or false)

    if saveData["Engine Running"] then
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
    end
    for i, modName in pairs(vehiclelib.MOD_NAMES) do
        if saveData.Mods[modName] then
            VEHICLE.SET_VEHICLE_MOD(vehicle, i - 1, saveData.Mods[modName])
        end
    end
    if saveData.Mods.Toggles then
        for i, mod in pairs(vehiclelib.TOGGLEABLE_MOD_NAMES) do
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i - 1, saveData.Mods.Toggles[mod])
        end
    end
    if saveData.Extras then
        for x = 0, vehiclelib.MAX_EXTRAS do
            if saveData.Extras[tostring(x-1)] or saveData.Extras[(x-1)] then -- If true, set to 0 (its flipped for some reason)
                VEHICLE.SET_VEHICLE_EXTRA(vehicle, x, false)
            end
        end
    end

    -- Misc
    VEHICLE.SET_VEHICLE_LIVERY(vehicle, saveData.Livery.style or -1)
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, saveData["Window Tint"] or 0)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, saveData["License Plate"].Text or saveData["License Plate"] or "")
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, saveData["License Plate"].Type or 0)

end

function vehiclelib.ConvertXML(xmlStr)
    if not json then
        _G['json'] = require('json')
    end

    local loading = true
    local result = {
        data = nil,
        error = nil
    }
    async_http.init("jackz.me", "/stand/convert-api", function(body)
        local status, json = pcall(json.decode, body)
        if status then
            result.data = json.data
            result.error = json.error
        else
            result.error = "Invalid Server Response"
        end
        loading = false
    end, function() end)
    async_http.set_post("text/plain", xmlStr)
    async_http.add_header("vehiclelib-version",vehiclelib.LIB_VERSION)
    async_http.add_header("vehiclelib-format",vehiclelib.FORMAT_VERSION)
    async_http.dispatch()
    while loading do
        util.yield()
    end
    return result
end

return vehiclelib

