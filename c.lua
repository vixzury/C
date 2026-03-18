task.defer(function()
    if not game:IsLoaded() then game.Loaded:Wait() end
    
    local LocalPlayer = game:GetService("Players").LocalPlayer
    if not LocalPlayer.Character then LocalPlayer.CharacterAdded:Wait() end
    local Mouse = LocalPlayer:GetMouse()
    task.wait(1)
    
    local CurrentScriptID = os.clock()
    _G.CelesitalScriptRunningID = CurrentScriptID
    
    local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
    local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
    local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
    local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
    
    local function AddIconToTab(TabName, IconId)
        local MainFrame = Library.ScreenGui:FindFirstChild("Main")
        local TabButton
        if MainFrame then
            local TabHolder = MainFrame:FindFirstChild("Container") and MainFrame.Container:FindFirstChild("TabHolder")
            local SearchArea = TabHolder or MainFrame
            for _, v in pairs(SearchArea:GetDescendants()) do
                if v:IsA("TextLabel") and v.Text == TabName and v.Parent and v.Parent:IsA("Frame") then
                    TabButton = v.Parent
                    break
                end
            end
        end
        if TabButton and not TabButton:FindFirstChild("TabIcon") then
            local Label = TabButton:FindFirstChildOfClass("TextLabel")
            if Label then
                Label.TextXAlignment = Enum.TextXAlignment.Right
                if not Label:FindFirstChildOfClass("UIPadding") then
                    Instance.new("UIPadding", Label).PaddingRight = UDim.new(0, 6)
                end
            end
            TabButton.Size = TabButton.Size + UDim2.new(0, 20, 0, 0)
            local Icon = Instance.new("ImageLabel")
            Icon.Name = "TabIcon"
            Icon.BackgroundTransparency = 1
            Icon.Size = UDim2.new(0, 16, 0, 16)
            Icon.Position = UDim2.new(0, 4, 0.5, -8)
            Icon.Image = "rbxassetid://" .. tostring(IconId)
            Icon.ImageColor3 = Library.FontColor
            Icon.Parent = TabButton
            Library:AddToRegistry(Icon, { ImageColor3 = 'FontColor' })
        end
    end


    local Window = Library:CreateWindow({
        Title = 'Celesital | Dahood',
        Center = true,
        AutoShow = true,
        TabPadding = 8,
        MenuFadeTime = 0.2
    })
    
    local Tabs = {
        Main = Window:AddTab('Combat'),
    }
    task.wait()
    Tabs.Visuals = Window:AddTab('Visuals')
    task.wait()
    Tabs.Misc = Window:AddTab('Misc')
    task.wait()
    Tabs.Players = Window:AddTab('Players')
    task.wait()
    Tabs['UI Settings'] = Window:AddTab('Settings')

    task.delay(0.1, function()
        AddIconToTab('Combat', '138383951378756')
        AddIconToTab('Visuals', '115907015044719')
        AddIconToTab('Misc', '112887626955824')
        AddIconToTab('Players', '13813134260')
        AddIconToTab('Settings', '137300573942266')
    end)
    
    local Toggles = getgenv().Toggles or {}
    local Options = getgenv().Options or {}
    


    local TriggerbotGroupBox = Tabs.Main:AddLeftGroupbox('Triggerbot')
    TriggerbotGroupBox:AddToggle('TriggerbotEnabled', { Text = 'Enabled', Default = false }):AddKeyPicker('TriggerbotKey', { Default = 'None', NoUI = false, Text = 'Triggerbot Toggle' })
    TriggerbotGroupBox:AddToggle('SmartTriggerbot', { Text = 'Smart Triggerbot', Default = false })
    TriggerbotGroupBox:AddToggle('TriggerbotWallCheck', { Text = 'Wall Check', Default = true })
    TriggerbotGroupBox:AddToggle('TriggerbotKnockedCheck', { Text = 'Ignore Knocked', Default = true })
    TriggerbotGroupBox:AddToggle('TriggerbotHealthCheck', { Text = 'Health Check', Default = true })
    TriggerbotGroupBox:AddToggle('TriggerbotKnifeCheck', { Text = 'Knife Check', Default = true })
    TriggerbotGroupBox:AddSlider('TriggerbotMaxDist', { Text = 'Max Distance', Default = 500, Min = 10, Max = 5000, Rounding = 0, Compact = true })
    TriggerbotGroupBox:AddSlider('TriggerbotDelay', { Text = 'Delay (ms)', Default = 0, Min = 0, Max = 500, Rounding = 0, Compact = true })

    local AimbotGroupBox = Tabs.Main:AddLeftGroupbox('Aimbot')
    AimbotGroupBox:AddToggle('AimbotEnabled', { Text = 'Enabled', Default = false }):AddKeyPicker('AimbotKey', { Default = 'None', NoUI = false, Text = 'Aimbot key' })
    AimbotGroupBox:AddToggle('AimbotSticky', { Text = 'Sticky', Default = false })
    AimbotGroupBox:AddSlider('AimbotSmoothing', { Text = 'Smoothing', Default = 1, Min = 1, Max = 20, Rounding = 0, Compact = true })
    AimbotGroupBox:AddToggle('AimbotPrediction', { Text = 'Prediction', Default = false })
    AimbotGroupBox:AddSlider('AimbotPredictionFactor', { Text = 'Prediction Factor', Default = 0.165, Min = 0.001, Max = 1, Rounding = 3, Compact = true })
    
    AimbotGroupBox:AddDivider()
    AimbotGroupBox:AddToggle('AimbotAutoPrediction', { Text = 'Auto Prediction (Ping)', Default = false })
    AimbotGroupBox:AddToggle('AimbotWallCheck', { Text = 'Wall Check', Default = true })
    AimbotGroupBox:AddToggle('AimbotKnockedCheck', { Text = 'Ignore Knocked', Default = true })
    AimbotGroupBox:AddToggle('AimbotHealthCheck', { Text = 'Health Check', Default = true })
    AimbotGroupBox:AddToggle('AimbotShowFOV', { Text = 'Show FOV', Default = false }):AddColorPicker('AimbotFOVColor', { Default = Color3.new(1, 0, 0), Title = 'Aimbot FOV Color' })
    AimbotGroupBox:AddSlider('AimbotFOVRadius', { Text = 'FOV Radius', Default = 80, Min = 10, Max = 800, Rounding = 0, Compact = true })
    AimbotGroupBox:AddDropdown('AimbotHitPart', { Values = { 'Head', 'UpperTorso', 'HumanoidRootPart', 'LowerTorso' }, Default = 1, Multi = false, Text = 'Target Part' })

    local SilentAimGroupBox = Tabs.Main:AddRightGroupbox('Silent Aim')
    SilentAimGroupBox:AddToggle('SilentAimEnabled', { Text = 'Enabled', Default = false }):AddKeyPicker('SilentAimKey', { Default = 'None', NoUI = false, Text = 'Silent Aim Toggle' })
    SilentAimGroupBox:AddToggle('SilentAimSticky', { Text = 'Sticky', Default = false })
    SilentAimGroupBox:AddToggle('SilentAimWallCheck', { Text = 'Wall Check', Default = true })
    SilentAimGroupBox:AddToggle('SilentAimKnockedCheck', { Text = 'Ignore Knocked', Default = true })
    SilentAimGroupBox:AddToggle('SilentAimHealthCheck', { Text = 'Health Check', Default = true })
    SilentAimGroupBox:AddToggle('SilentAimShowFOV', { Text = 'Show FOV', Default = false }):AddColorPicker('SilentAimFOVColor', { Default = Color3.new(1, 1, 1), Title = 'FOV Color' })
    SilentAimGroupBox:AddSlider('SilentAimFOVRadius', { Text = 'FOV Radius', Default = 80, Min = 10, Max = 800, Rounding = 0, Compact = true })
    SilentAimGroupBox:AddDropdown('SilentAimHitPart', { Values = { 'Head', 'UpperTorso', 'HumanoidRootPart', 'LowerTorso' }, Default = 1, Multi = false, Text = 'Target Part' })
    SilentAimGroupBox:AddToggle('SilentAimShowTracer', { Text = 'Show Tracer', Default = false }):AddColorPicker('SilentAimTracerColor', { Default = Color3.new(1, 1, 1), Title = 'Tracer Color' })
    SilentAimGroupBox:AddToggle('SilentAimPrediction', { Text = 'Prediction', Default = false })
    SilentAimGroupBox:AddSlider('SilentAimPredictionFactor', { Text = 'Prediction Factor', Default = 0.135, Min = 0, Max = 1, Rounding = 3, Compact = true })
    SilentAimGroupBox:AddToggle('SilentAimAutoPrediction', { Text = 'Auto Prediction (Ping)', Default = false })
    
    local HitNotifyGroupBox = Tabs.Main:AddRightGroupbox('Hit Notify')
    HitNotifyGroupBox:AddToggle('HitNotifyEnabled', { Text = 'Enabled', Default = false })
    HitNotifyGroupBox:AddDropdown('HitNotifyOptions', {
        Values = { 'Damage', 'Hit Part', 'Remaining Health' },
        Default = 1,
        Multi = true,
        Text = 'Notify Details'
    })
    
    local ESPGroupBox = Tabs.Visuals:AddLeftGroupbox('ESP')
    ESPGroupBox:AddToggle('ESPEnabled', { Text = 'Enabled', Default = false }):AddColorPicker('ESPColor', { Default = Color3.new(1, 1, 1), Title = 'ESP Color' })
    ESPGroupBox:AddToggle('ESPBoxes', { Text = 'Boxes', Default = false }):AddColorPicker('ESPBoxColor', { Default = Color3.new(1, 1, 1), Title = 'Box Color' })
    ESPGroupBox:AddToggle('ESPNames', { Text = 'Names', Default = false }):AddColorPicker('ESPNameColor', { Default = Color3.new(1, 1, 1), Title = 'Name Color' })
    ESPGroupBox:AddToggle('ESPWeapon', { Text = 'Equipped Weapon', Default = false }):AddColorPicker('ESPWeaponColor', { Default = Color3.new(1, 1, 1), Title = 'Weapon Color' })
    ESPGroupBox:AddToggle('ESPHealthBar', { Text = 'Health Bar', Default = false })
    ESPGroupBox:AddToggle('ESPHealthText', { Text = 'Health Text', Default = false })
    ESPGroupBox:AddToggle('ESPHealthTextDynamic', { Text = 'Dynamic Health Pos', Default = false })
    ESPGroupBox:AddToggle('ESPArmorBar', { Text = 'Armor Bar', Default = false }):AddColorPicker('ESPArmorColor', { Default = Color3.new(0, 0.5, 1), Title = 'Armor Color' })
    ESPGroupBox:AddToggle('ESPArmorText', { Text = 'Armor Text', Default = false })
    ESPGroupBox:AddToggle('ESPArmorTextDynamic', { Text = 'Dynamic Armor Pos', Default = false })
    ESPGroupBox:AddToggle('ESPDistance', { Text = 'Distance', Default = false }):AddColorPicker('ESPDistanceColor', { Default = Color3.new(1, 1, 1), Title = 'Distance Color' })

    ESPGroupBox:AddDivider()
    ESPGroupBox:AddDropdown('ESPNameType', { Values = { 'Display Name', 'Username' }, Default = 1, Multi = false, Text = 'Name ESP Type' })
    ESPGroupBox:AddDropdown('BoxStyle', {
        Values = { 'Full', 'Corner' },
        Default = 1,
        Multi = false,
        Text = 'Box Style'
    })
    ESPGroupBox:AddSlider('ESPMaxDist', {
        Text = 'Max Distance',
        Default = 1000,
        Min = 100,
        Max = 9999999,
        Rounding = 0,
        Compact = false
    })

    local ChamsGroupBox = Tabs.Visuals:AddRightGroupbox('Chams')
    ChamsGroupBox:AddToggle('ChamsEnabled', { Text = 'Enabled', Default = false }):AddColorPicker('ChamsColor', { Default = Color3.fromRGB(255, 100, 200), Title = 'Chams Color' })
    ChamsGroupBox:AddToggle('ChamsAlwaysOnTop', { Text = 'Always On Top', Default = true })
    
    local SpeedGroupBox = Tabs.Misc:AddLeftGroupbox('Speed')
    SpeedGroupBox:AddToggle('CFrameSpeedEnabled', { Text = 'CFrame Speed', Default = false }):AddKeyPicker('CFrameSpeedKey', { Default = 'None', NoUI = false, Text = 'CFrame Speed Toggle' })
    SpeedGroupBox:AddSlider('CFrameSpeed', { Text = 'Speed Multiplier', Default = 1, Min = 1, Max = 10, Rounding = 1, Compact = true })
    
    SpeedGroupBox:AddDivider()
    
    SpeedGroupBox:AddToggle('BetterSpeedEnabled', { Text = 'Better WalkSpeed', Default = false }):AddKeyPicker('BetterSpeedKey', { Default = 'None', NoUI = false, Text = 'Better Speed Toggle' })
    SpeedGroupBox:AddSlider('BetterWalkSpeed', { Text = 'WalkSpeed Value', Default = 16, Min = 16, Max = 1000, Rounding = 0, Compact = true })

    local FlyGroupBox = Tabs.Misc:AddRightGroupbox('Fly')
    FlyGroupBox:AddToggle('CFrameFlyEnabled', { Text = 'CFrame Fly', Default = false }):AddKeyPicker('CFrameFlyKey', { Default = 'None', NoUI = false, Text = 'CFrame Fly Toggle' })
    FlyGroupBox:AddSlider('CFrameFlySpeed', { Text = 'Fly Speed', Default = 1, Min = 1, Max = 100, Rounding = 1, Compact = true })
    FlyGroupBox:AddSlider('CFrameFlyVertical', { Text = 'Fly Vertical Speed', Default = 1, Min = 1, Max = 100, Rounding = 1, Compact = true })

    local JumpGroupBox = Tabs.Misc:AddLeftGroupbox('Jump')
    JumpGroupBox:AddToggle('JumpPowerEnabled', { Text = 'Jump Power', Default = false }):AddKeyPicker('JumpPowerKey', { Default = 'None', NoUI = false, Text = 'Jump Power Toggle' })
    JumpGroupBox:AddSlider('JumpPowerValue', { Text = 'Jump Power Value', Default = 50, Min = 50, Max = 1000, Rounding = 0, Compact = true })
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    
    local PlayerGroupBox = Tabs.Players:AddLeftGroupbox('Player Management')
    PlayerGroupBox:AddDropdown('PlayerWhitelist', {
        Values = {},
        Default = 1,
        Multi = true,
        Text = 'Whitelist (Ignore)'
    })
    PlayerGroupBox:AddDropdown('PlayerPriority', {
        Values = {},
        Default = 1,
        Multi = true,
        Text = 'Priority (Target First)'
    })
    
    local function getPlayerNames()
        local names = {}
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= LocalPlayer then
                table.insert(names, v.Name)
            end
        end
        return names
    end

    local function updatePlayerLists()
        local players = getPlayerNames()
        Options.PlayerWhitelist:SetValues(players)
        Options.PlayerPriority:SetValues(players)
    end

    game:GetService("Players").PlayerAdded:Connect(updatePlayerLists)
    game:GetService("Players").PlayerRemoving:Connect(updatePlayerLists)

    PlayerGroupBox:AddButton('Refresh Player Lists', function()
        updatePlayerLists()
        Library:Notify("Player lists refreshed!", 2)
    end)

    updatePlayerLists()

    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
    ThemeManager:SetFolder('Celesital')
    SaveManager:SetFolder('Celesital/Settings')
    SaveManager:BuildConfigSection(Tabs['UI Settings'])
    ThemeManager:ApplyToTab(Tabs['UI Settings'])
    
    local SettingsGroupBox = Tabs['UI Settings']:AddRightGroupbox('Menu')
    SettingsGroupBox:AddButton('Unload', function()
        if _G.UnloadCelesital then _G.UnloadCelesital() end
    end)
    SettingsGroupBox:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'RightShift', NoUI = true, Text = 'Menu keybind' })
    Library.ToggleKeybind = Options.MenuKeybind
    
    SettingsGroupBox:AddToggle('ShowKeybinds', { Text = 'Show Keybinds', Default = false }):OnChanged(function()
        Library.KeybindFrame.Visible = Toggles.ShowKeybinds.Value
    end)
    
    SaveManager:LoadAutoloadConfig()
    
    local connections = {}
    
    local lastClickTime = 0
    table.insert(connections, UserInputService.InputBegan:Connect(function(input, gpe)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not gpe then
            lastClickTime = os.clock()
        end
    end))
    
    table.insert(connections, UserInputService.JumpRequest:Connect(function()
        if Toggles.InfiniteJump and Toggles.InfiniteJump.Value then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end))
    
    local function isKnocked(char)
        if not char then return false end
        local bodyEffects = char:FindFirstChild("BodyEffects")
        local knocked = bodyEffects and (bodyEffects:FindFirstChild("Knocked") or bodyEffects:FindFirstChild("K.O"))
        if knocked and knocked:IsA("ValueBase") then
            return knocked.Value
        end
        return false
    end

    local function wallCheck(targetPart)
        if not targetPart or not targetPart.Parent then return false end
        local cam = Workspace.CurrentCamera
        local rayparams = RaycastParams.new()
        rayparams.FilterType = Enum.RaycastFilterType.Exclude
        rayparams.FilterDescendantsInstances = {LocalPlayer.Character, cam}
        
        local result = workspace:Raycast(cam.CFrame.Position, (targetPart.Position - cam.CFrame.Position).Unit * 500, rayparams)
        if result and result.Instance:IsDescendantOf(targetPart.Parent) then
            return true
        end
        return false
    end

    local function getClosestPlayerToMouse(radius, hitPartName, checkWall, checkKnocked, checkHealth)
        local closest, dist = nil, radius or (Options.SilentAimFOVRadius and Options.SilentAimFOVRadius.Value or 80)
        local hitPart = hitPartName or (Options.SilentAimHitPart and Options.SilentAimHitPart.Value or "Head")
        local cam = Workspace.CurrentCamera
        local players = game:GetService("Players"):GetPlayers()
        
        for _, v in pairs(players) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(hitPart) and v.Character:FindFirstChild("Humanoid") then
                local isPriority = Options.PlayerPriority and Options.PlayerPriority.Value and Options.PlayerPriority.Value[v.Name]
                local isWhitelisted = Options.PlayerWhitelist and Options.PlayerWhitelist.Value and Options.PlayerWhitelist.Value[v.Name]
                
                if (isPriority and not isWhitelisted) or (not Options.PlayerPriority) or (not Options.PlayerPriority.Value) then
                    local targetPart = v.Character[hitPart]
                    local targetHum = v.Character.Humanoid
                    
                    if checkHealth and targetHum.Health <= 0 then continue end
                    if checkKnocked and isKnocked(v.Character) then continue end
                    if checkWall and not wallCheck(targetPart) then continue end

                    local pos, onScreen = cam:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local mousePos = UserInputService:GetMouseLocation()
                        local d = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                        if d < dist then
                            closest = v
                            dist = d
                        end
                    end
                end
            end
        end

        if closest then return closest end

        for _, v in pairs(players) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(hitPart) and v.Character:FindFirstChild("Humanoid") then
                local isWhitelisted = Options.PlayerWhitelist and Options.PlayerWhitelist.Value and Options.PlayerWhitelist.Value[v.Name]
                
                if not isWhitelisted then
                    local targetPart = v.Character[hitPart]
                    local targetHum = v.Character.Humanoid

                    if checkHealth and targetHum.Health <= 0 then continue end
                    if checkKnocked and isKnocked(v.Character) then continue end
                    if checkWall and not wallCheck(targetPart) then continue end

                    local pos, onScreen = cam:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local mousePos = UserInputService:GetMouseLocation()
                        local d = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                        if d < dist then
                            closest = v
                            dist = d
                        end
                    end
                end
            end
        end
        return closest
    end
    
    local function onCharacterAdded(player, char)
        local hum = char:WaitForChild("Humanoid", 5)
        if not hum then return end
        
        local lastHealth = hum.Health
        local c = hum.HealthChanged:Connect(function(newHealth)
            if newHealth < lastHealth then
                local damage = lastHealth - newHealth
                if Toggles.HitNotifyEnabled and Toggles.HitNotifyEnabled.Value then
                    local wasMe = false
                    local creator = hum:FindFirstChild("creator") or char:FindFirstChild("creator")
                    
                    if creator and creator.Value == LocalPlayer then
                        wasMe = true
                    else
                        local clickedRecently = (os.clock() - lastClickTime) < 0.6
                        local holdingTool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        local usingTriggerbot = Toggles.TriggerbotEnabled and Toggles.TriggerbotEnabled.Value and Options.TriggerbotKey:GetState()
                        
                        if (clickedRecently or usingTriggerbot) and holdingTool then
                            local cam = Workspace.CurrentCamera
                            local root = char:FindFirstChild("HumanoidRootPart")
                            if root then
                                local pos, onScreen = cam:WorldToViewportPoint(root.Position)
                                if onScreen then
                                    local mousePos = UserInputService:GetMouseLocation()
                                    local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                                    local requiredDist = math.max((Options.SilentAimFOVRadius and Options.SilentAimFOVRadius.Value or 80) + 50, (Options.AimbotFOVRadius and Options.AimbotFOVRadius.Value or 80) + 50)
                                    if dist < requiredDist then
                                        local closest = getClosestPlayerToMouse(requiredDist, nil, false, false, false)
                                        if closest == player then
                                            wasMe = true
                                        elseif dist < 35 then
                                            wasMe = true 
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    if wasMe then
                        local msg = "Hit " .. player.DisplayName
                        local options = Options.HitNotifyOptions.Value
                        if type(options) == "table" then
                            if options["Hit Part"] then msg = msg .. " in the " .. tostring(Options.SilentAimHitPart.Value or "Body") end
                            if options["Damage"] then msg = msg .. " for " .. tostring(math.floor(damage)) end
                            if options["Remaining Health"] then msg = msg .. " (" .. tostring(math.floor(newHealth)) .. " left)" end
                        end
                        Library:Notify(msg, 3)
                    end
                end
            end
            lastHealth = newHealth
        end)
        table.insert(connections, c)
    end
    
    local function setupHitNotifyForPlayer(player)
        if player.Character then
            task.spawn(onCharacterAdded, player, player.Character)
        end
        local c = player.CharacterAdded:Connect(function(char)
            onCharacterAdded(player, char)
        end)
        table.insert(connections, c)
    end
    
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= LocalPlayer then
            setupHitNotifyForPlayer(player)
        end
    end
    table.insert(connections, game:GetService("Players").PlayerAdded:Connect(setupHitNotifyForPlayer))
    
    local function getArmor(char)
        if not char then return 0, 0 end
        local armor, maxArmor = 0, 200
        

        local bodyEffects = char:FindFirstChild("BodyEffects")
        if bodyEffects then
            local armorVal = bodyEffects:FindFirstChild("Armor")
            if armorVal and armorVal:IsA("ValueBase") then
                armor = armorVal.Value
            end
        end

        if armor == 0 then
            local bodyArmor = char:FindFirstChild("BodyArmor")
            if bodyArmor then
                local armorBody = bodyArmor:FindFirstChild("ArmorBody")
                if armorBody and armorBody:IsA("ValueBase") then
                    armor = armorBody.Value
                end
            end
        end

        if armor == 0 then
            local stats = char:FindFirstChild("Stats")
            if stats then
                local a = stats:FindFirstChild("Armor")
                if a and a:IsA("ValueBase") then
                    armor = a.Value
                end
            end
        end


        if char:FindFirstChild("MaxArmor") then
            maxArmor = char.MaxArmor.Value
        elseif char:FindFirstChild("Stats") and char.Stats:FindFirstChild("MaxArmor") then
            maxArmor = char.Stats.MaxArmor.Value
        elseif armor > 200 then
            maxArmor = armor
        end

        return armor, maxArmor
    end

    local fov_circle = Drawing.new("Circle")
    fov_circle.Thickness = 1
    fov_circle.NumSides = 64
    fov_circle.Filled = false
    fov_circle.Visible = false

    local aimbot_fov_circle = Drawing.new("Circle")
    aimbot_fov_circle.Thickness = 1
    aimbot_fov_circle.NumSides = 64
    aimbot_fov_circle.Filled = false
    local silent_aim_tracer = Drawing.new("Line")
    silent_aim_tracer.Thickness = 1
    silent_aim_tracer.Visible = false

    local esp_objects = {}

    local function create_esp(player)
        if esp_objects[player] then return end
        local objects = {
            box = Drawing.new("Square"),
            dist = Drawing.new("Text"),
            name = Drawing.new("Text"),
            weapon = Drawing.new("Text"),
            health_bg = Drawing.new("Square"),
            health_bar = Drawing.new("Square"),
            armor_bg = Drawing.new("Square"),
            armor_bar = Drawing.new("Square"),
            health_text = Drawing.new("Text"),
            armor_text = Drawing.new("Text"),
            corners = {},
            chams = {},
        }
        
        objects.box.Thickness = 1; objects.box.Filled = false; objects.box.Visible = false
        
        objects.dist.Size = 14; objects.dist.Center = true; objects.dist.Outline = true; objects.dist.Visible = false
        objects.name.Size = 14; objects.name.Center = true; objects.name.Outline = true; objects.name.Visible = false
        objects.weapon.Size = 14; objects.weapon.Center = true; objects.weapon.Outline = true; objects.weapon.Visible = false
        
        objects.health_bg.Thickness = 1; objects.health_bg.Filled = true; objects.health_bg.Visible = false; objects.health_bg.Color = Color3.new(0, 0, 0)
        objects.health_bar.Thickness = 1; objects.health_bar.Filled = true; objects.health_bar.Visible = false; objects.health_bar.Color = Color3.new(0, 1, 0)
        
        objects.armor_bg.Thickness = 1; objects.armor_bg.Filled = true; objects.armor_bg.Visible = false; objects.armor_bg.Color = Color3.new(0, 0, 0)
        objects.armor_bar.Thickness = 1; objects.armor_bar.Filled = true; objects.armor_bar.Visible = false; objects.armor_bar.Color = Color3.new(0, 0.5, 1)

        for _, key in pairs({"health_text", "armor_text"}) do
            local obj = objects[key]
            obj.Size = 13
            obj.Center = true
            obj.Outline = true
            obj.Color = Color3.new(1, 1, 1)
            obj.Visible = false
            obj.Font = 2
        end

        for i = 1, 8 do
            local line = Drawing.new("Line")
            line.Thickness = 1; line.Visible = false
            table.insert(objects.corners, line)
        end
        
        esp_objects[player] = objects
    end

    local function remove_esp(player)
        if esp_objects[player] then
            local obj = esp_objects[player]
            obj.box:Remove(); obj.dist:Remove(); obj.name:Remove(); obj.weapon:Remove()
            obj.health_bg:Remove(); obj.health_bar:Remove()
            obj.armor_bg:Remove(); obj.armor_bar:Remove()
            obj.health_text:Remove(); obj.armor_text:Remove()
            for _, line in pairs(obj.corners) do line:Remove() end
            for _, adorn in pairs(obj.chams) do adorn:Destroy() end
            esp_objects[player] = nil
        end
    end

    game:GetService("Players").PlayerRemoving:Connect(remove_esp)

    local betterSpeedActive = false
    table.insert(connections, RunService.RenderStepped:Connect(function()
        if not LocalPlayer.Character then return end
        local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local Hum  = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if not Root or not Hum or Hum.Health <= 0 then 
            for _, objects in pairs(esp_objects) do
                objects.box.Visible = false
                objects.dist.Visible = false
                objects.name.Visible = false
                objects.weapon.Visible = false
                objects.health_bg.Visible = false; objects.health_bar.Visible = false
                objects.armor_bg.Visible = false; objects.armor_bar.Visible = false
                objects.health_text.Visible = false; objects.armor_text.Visible = false 
                for _, line in pairs(objects.corners) do line.Visible = false end
                for _, adorn in pairs(objects.chams) do adorn.Visible = false end
            end
            return 
        end


        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= LocalPlayer then
                create_esp(player)
                local objects = esp_objects[player]
                local char = player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local cam = Workspace.CurrentCamera
                
                local visible = false
                if Toggles.ESPEnabled and Toggles.ESPEnabled.Value and root and hum and hum.Health > 0 then
                    local distance = (Root.Position - root.Position).Magnitude
                    if distance <= Options.ESPMaxDist.Value then
                        local pos, onScreen = cam:WorldToViewportPoint(root.Position)
                        if onScreen then
                            visible = true
                            local color = Options.ESPColor.Value
                            
                            local top = cam:WorldToViewportPoint(root.Position + Vector3.new(0, 3, 0)).Y
                            local bottom = cam:WorldToViewportPoint(root.Position - Vector3.new(0, 3.5, 0)).Y
                            local size_y = bottom - top
                            local size_x = size_y / 1.5
                            local box_pos = Vector2.new(pos.X - size_x / 2, top)
                            local box_size = Vector2.new(size_x, size_y)

                            if Toggles.ESPBoxes.Value then
                                local color = Options.ESPBoxColor.Value
                                if Options.BoxStyle.Value == 'Full' then
                                    objects.box.Visible = true
                                    objects.box.Position = box_pos
                                    objects.box.Size = Vector2.new(size_x, size_y)
                                    objects.box.Color = color
                                    for _, line in pairs(objects.corners) do line.Visible = false end
                                else
                                    objects.box.Visible = false
                                    local corner_length = size_x / 4; local lines = objects.corners
                                    lines[1].From = box_pos; lines[1].To = box_pos + Vector2.new(corner_length, 0)
                                    lines[2].From = box_pos; lines[2].To = box_pos + Vector2.new(0, corner_length)
                                    lines[3].From = box_pos + Vector2.new(size_x, 0); lines[3].To = box_pos + Vector2.new(size_x - corner_length, 0)
                                    lines[4].From = box_pos + Vector2.new(size_x, 0); lines[4].To = box_pos + Vector2.new(size_x, corner_length)
                                    lines[5].From = box_pos + Vector2.new(0, size_y); lines[5].To = box_pos + Vector2.new(corner_length, size_y)
                                    lines[6].From = box_pos + Vector2.new(0, size_y); lines[6].To = box_pos + Vector2.new(0, size_y - corner_length)
                                    lines[7].From = box_pos + Vector2.new(size_x, size_y); lines[7].To = box_pos + Vector2.new(size_x - corner_length, size_y)
                                    lines[8].From = box_pos + Vector2.new(size_x, size_y); lines[8].To = box_pos + Vector2.new(size_x, size_y - corner_length)
                                    for _, line in pairs(lines) do line.Color = color; line.Visible = true end
                                end
                            else
                                objects.box.Visible = false
                                for _, line in pairs(objects.corners) do line.Visible = false end
                            end

                            if Toggles.ESPNames.Value then
                                objects.name.Visible = true
                                objects.name.Position = Vector2.new(box_pos.X + size_x / 2, box_pos.Y - 15)
                                local nameType = Options.ESPNameType and Options.ESPNameType.Value or "Display Name"
                                objects.name.Text = (nameType == "Display Name") and (player.DisplayName ~= "" and player.DisplayName or player.Name) or player.Name
                                objects.name.Color = Options.ESPNameColor.Value
                            else
                                objects.name.Visible = false
                            end

                            if Toggles.ESPDistance.Value then
                                objects.dist.Visible = true
                                objects.dist.Position = Vector2.new(box_pos.X + size_x / 2, box_pos.Y + size_y + 2)
                                objects.dist.Text = "[" .. math.floor(distance) .. "m]"
                                objects.dist.Color = Options.ESPDistanceColor.Value
                            else
                                objects.dist.Visible = false
                            end

                            if Toggles.ESPWeapon.Value then
                                local tool = char:FindFirstChildOfClass("Tool")
                                objects.weapon.Visible = true
                                objects.weapon.Position = Vector2.new(box_pos.X + size_x / 2, box_pos.Y + size_y + (Toggles.ESPDistance.Value and 15 or 2))
                                objects.weapon.Text = tostring(tool and tool.Name or "None")
                                objects.weapon.Color = Options.ESPWeaponColor.Value
                            else
                                objects.weapon.Visible = false
                            end

                            if Toggles.ESPHealthBar.Value then
                                local health_percent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                                objects.health_bg.Visible = true
                                objects.health_bg.Position = Vector2.new(box_pos.X - 6, box_pos.Y - 1)
                                objects.health_bg.Size = Vector2.new(4, size_y + 2)
                                
                                objects.health_bar.Visible = true
                                objects.health_bar.Position = Vector2.new(box_pos.X - 5, box_pos.Y + (size_y * (1 - health_percent)))
                                objects.health_bar.Size = Vector2.new(2, size_y * health_percent)
                                objects.health_bar.Color = Color3.fromHSV(health_percent * 0.3, 1, 1)

                                if Toggles.ESPHealthText.Value then
                                    objects.health_text.Visible = true
                                    local textPos = box_pos.Y + size_y / 2
                                    if Toggles.ESPHealthTextDynamic.Value then
                                        textPos = box_pos.Y + (size_y * (1 - health_percent))
                                    end
                                    objects.health_text.Position = Vector2.new(box_pos.X - 12, textPos - 7)
                                    objects.health_text.Text = tostring(math.floor(hum.Health))
                                    objects.health_text.Center = true
                                    objects.health_text.Color = Color3.new(1, 1, 1)
                                else
                                    objects.health_text.Visible = false
                                end
                            else
                                objects.health_bg.Visible = false; objects.health_bar.Visible = false
                                objects.health_text.Visible = false
                            end

                            local armor, maxArmor = getArmor(char)
                            if Toggles.ESPArmorBar.Value and maxArmor > 0 then
                                local armor_percent = math.clamp(armor / maxArmor, 0, 1)
                                if armor_percent > 0 then
                                    objects.armor_bg.Visible = true
                                    objects.armor_bg.Position = Vector2.new(box_pos.X + size_x + 2, box_pos.Y - 1)
                                    objects.armor_bg.Size = Vector2.new(4, size_y + 2)
                                    
                                    objects.armor_bar.ZIndex = 3
                                    objects.armor_bar.Visible = true
                                    objects.armor_bar.Position = Vector2.new(box_pos.X + size_x + 3, box_pos.Y + (size_y * (1 - armor_percent)))
                                    objects.armor_bar.Size = Vector2.new(2, size_y * armor_percent)
                                    objects.armor_bar.Color = Options.ESPArmorColor.Value

                                    if Toggles.ESPArmorText.Value then
                                        objects.armor_text.Visible = true
                                        local textPos = box_pos.Y + size_y / 2
                                        if Toggles.ESPArmorTextDynamic.Value then
                                            textPos = box_pos.Y + (size_y * (1 - armor_percent))
                                        end
                                        objects.armor_text.Position = Vector2.new(box_pos.X + size_x + 12, textPos - 7)
                                        objects.armor_text.Text = tostring(math.floor(armor))
                                        objects.armor_text.Color = Options.ESPArmorColor.Value
                                        objects.armor_text.Center = true
                                    else
                                        objects.armor_text.Visible = false
                                    end
                                else
                                    objects.armor_bg.Visible = false; objects.armor_bar.Visible = false
                                    objects.armor_text.Visible = false
                                end
                            else
                                objects.armor_bg.Visible = false; objects.armor_bar.Visible = false
                                objects.armor_text.Visible = false
                            end
                        end
                    end
                end
                
                if Toggles.ChamsEnabled and Toggles.ChamsEnabled.Value and char and hum and hum.Health > 0 then
                    for _, part in pairs(char:GetChildren()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            local adorn = objects.chams[part]
                            if not adorn then
                                adorn = Instance.new("BoxHandleAdornment")
                                adorn.Name = "Cham"
                                adorn.Parent = game:GetService("CoreGui")
                                objects.chams[part] = adorn
                            end
                            adorn.Adornee = part
                            adorn.Size = part.Size + Vector3.new(0.1, 0.1, 0.1)
                            adorn.Color3 = Options.ChamsColor.Value
                            adorn.AlwaysOnTop = Toggles.ChamsAlwaysOnTop.Value
                            adorn.ZIndex = 5
                            adorn.Transparency = 0 
                            adorn.Visible = true
                        end
                    end
                else
                    for _, adorn in pairs(objects.chams) do adorn.Visible = false end
                end

                if not visible then
                    objects.box.Visible = false
                    objects.dist.Visible = false
                    objects.name.Visible = false
                    objects.weapon.Visible = false
                    objects.health_bg.Visible = false; objects.health_bar.Visible = false
                    objects.armor_bg.Visible = false; objects.armor_bar.Visible = false
                    objects.health_text.Visible = false; objects.armor_text.Visible = false
                    for _, line in pairs(objects.corners) do line.Visible = false end
                end
            end
        end

        if Toggles.CFrameSpeedEnabled and Toggles.CFrameSpeedEnabled.Value and Options.CFrameSpeedKey:GetState() and Hum.MoveDirection.Magnitude > 0 then
            Root.CFrame = Root.CFrame + (Hum.MoveDirection * (Options.CFrameSpeed.Value * 0.1))
        end

        if Toggles.CFrameFlyEnabled and Toggles.CFrameFlyEnabled.Value and Options.CFrameFlyKey:GetState() then
            local cam = Workspace.CurrentCamera
            local dir = Vector3.zero
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
            
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then 
                dir += Vector3.new(0, Options.CFrameFlyVertical.Value, 0) 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then 
                dir -= Vector3.new(0, Options.CFrameFlyVertical.Value, 0) 
            end
            
            if dir.Magnitude > 0 then
                local targetCF = Root.CFrame + (dir.Unit * (Options.CFrameFlySpeed.Value * 0.5))
                Root.CFrame = Root.CFrame:Lerp(targetCF, 0.5) 
            end
            Root.Velocity = Vector3.zero
        end

        if Toggles.BetterSpeedEnabled and Toggles.BetterSpeedEnabled.Value then
            local shouldBeActive = Options.BetterSpeedKey:GetState()
            if shouldBeActive ~= betterSpeedActive then
                betterSpeedActive = shouldBeActive
                if betterSpeedActive then
                    Hum.WalkSpeed = Options.BetterWalkSpeed.Value
                else
                    Hum.WalkSpeed = 16  
                end
            end
        end

        if Toggles.JumpPowerEnabled and Toggles.JumpPowerEnabled.Value then
            if Options.JumpPowerKey:GetState() then
                Hum.UseJumpPower = true
                Hum.JumpPower = Options.JumpPowerValue.Value
            else
                Hum.UseJumpPower = true
                Hum.JumpPower = 50 
            end
        else
            if Hum.JumpPower ~= 50 then
                Hum.UseJumpPower = true
                Hum.JumpPower = 50
            end
        end

        local mousePos = UserInputService:GetMouseLocation()
        if fov_circle then
            fov_circle.Visible = (Toggles.SilentAimShowFOV and Toggles.SilentAimShowFOV.Value) or false
            fov_circle.Radius  = (Options.SilentAimFOVRadius and Options.SilentAimFOVRadius.Value) or 80
            fov_circle.Color   = (Options.SilentAimFOVColor and Options.SilentAimFOVColor.Value) or Color3.new(1,1,1)
            fov_circle.Position = mousePos
        end
        if aimbot_fov_circle then
            aimbot_fov_circle.Visible = (Toggles.AimbotShowFOV and Toggles.AimbotShowFOV.Value) or false
            aimbot_fov_circle.Radius  = (Options.AimbotFOVRadius and Options.AimbotFOVRadius.Value) or 80
            aimbot_fov_circle.Color   = (Options.AimbotFOVColor and Options.AimbotFOVColor.Value) or Color3.new(1,0,0)
            aimbot_fov_circle.Position = mousePos
        end

    end))
    

    local function PerformCleanup()
        for _, c in pairs(connections) do
            pcall(function() c:Disconnect() end)
        end
        for _, player_objs in pairs(esp_objects) do

            for _, key in pairs({"box", "dist", "name", "weapon", "health_bg", "health_bar", "armor_bg", "armor_bar", "health_text", "armor_text"}) do
                if player_objs[key] then pcall(function() player_objs[key]:Remove() end) end
            end

            if player_objs.corners then
                for _, line in pairs(player_objs.corners) do
                    pcall(function() line:Remove() end)
                end
            end

            if player_objs.chams then
                for _, adorn in pairs(player_objs.chams) do
                    pcall(function() adorn:Destroy() end)
                end
            end
        end
        if fov_circle then pcall(function() fov_circle:Remove() end) end
        if aimbot_fov_circle then pcall(function() aimbot_fov_circle:Remove() end) end
        if silent_aim_tracer then pcall(function() silent_aim_tracer:Remove() end) end
        _G.UnloadCelesital = nil
    end

    local aimbot_target = nil
    local silent_aim_target = nil

    local function getPredictionPosition(targetPlayer, targetPartName, predictionEnabled, predictionFactor, autoPredictionEnabled)
        if not targetPlayer or not targetPlayer.Character then return nil end
        local targetPart = targetPlayer.Character:FindFirstChild(targetPartName)
        if not targetPart then return nil end

        if predictionEnabled then
            local factor = predictionFactor
            if autoPredictionEnabled then
                local ping = tonumber(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():split(" ")[1]) or 100
                factor = ping / 1000 
            end
            return targetPart.Position + (targetPart.Velocity * factor)
        end
        return targetPart.Position
    end


    table.insert(connections, RunService.Heartbeat:Connect(function()
        if Toggles.TriggerbotEnabled and Toggles.TriggerbotEnabled.Value then
            if not Options.TriggerbotKey:GetState() then return end

            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local tool = char and char:FindFirstChildOfClass("Tool")
            if not root then return end
            
            if Toggles.TriggerbotKnifeCheck.Value and tool then
                local isKnife = tool:FindFirstChild("Knife") or tool:FindFirstChild("Blade") or tool.Name:lower():find("knife") or tool.Name:lower():find("blade")
                if isKnife then return end
            end

            local targetChar, targetPart
            local smartTargetFound = false

            if Toggles.SmartTriggerbot and Toggles.SmartTriggerbot.Value then
                if silent_aim_target and silent_aim_target.Character then
                    targetChar = silent_aim_target.Character
                    targetPart = targetChar:FindFirstChild(Options.SilentAimHitPart.Value)
                    smartTargetFound = (targetPart ~= nil)
                end
                
                if not smartTargetFound and aimbot_target and aimbot_target.Character then
                    targetChar = aimbot_target.Character
                    targetPart = targetChar:FindFirstChild(Options.AimbotHitPart.Value)
                    smartTargetFound = (targetPart ~= nil)
                end
            end

            if not smartTargetFound then
                local mouseTarget = LocalPlayer:GetMouse().Target
                targetChar = mouseTarget and mouseTarget.Parent
                if targetChar and targetChar:IsA("Accessory") then targetChar = targetChar.Parent end
                targetPart = mouseTarget
            end
            
            local targetHum = targetChar and targetChar:FindFirstChildOfClass("Humanoid")
            local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

            if targetHum and targetRoot and targetHum.Health > 0 and targetPart then

                local player = game:GetService("Players"):GetPlayerFromCharacter(targetChar)
                if not player or player == LocalPlayer then return end

                if Options.PlayerWhitelist.Value[player.Name] then return end
                
                local dist = (root.Position - targetRoot.Position).Magnitude
                if dist > Options.TriggerbotMaxDist.Value then return end

                if Toggles.TriggerbotHealthCheck.Value and targetHum.Health <= 0 then return end

                if Toggles.TriggerbotKnockedCheck.Value and isKnocked(targetChar) then return end

                if Toggles.TriggerbotWallCheck.Value and not wallCheck(targetPart) then return end

                task.wait(Options.TriggerbotDelay.Value / 1000)
                if Toggles.TriggerbotEnabled.Value then
                    if Toggles.SmartTriggerbot.Value or (LocalPlayer:GetMouse().Target and LocalPlayer:GetMouse().Target:IsDescendantOf(targetChar)) then
                        mouse1click()
                    end
                end
            end
        end
    end))

    table.insert(connections, RunService.RenderStepped:Connect(function()
        local isSilentAimKeyHeld = Options.SilentAimKey:GetState()
        if isSilentAimKeyHeld then
            if Toggles.SilentAimSticky.Value then
                if silent_aim_target then
                    local char = silent_aim_target.Character
                    if not char or not (char:FindFirstChild(Options.SilentAimHitPart.Value) or char:FindFirstChild("HumanoidRootPart")) then
                        silent_aim_target = nil
                    end
                end
                
                if not silent_aim_target then
                    silent_aim_target = getClosestPlayerToMouse(
                        Options.SilentAimFOVRadius.Value, 
                        Options.SilentAimHitPart.Value,
                        Toggles.SilentAimWallCheck.Value,
                        Toggles.SilentAimKnockedCheck.Value,
                        Toggles.SilentAimHealthCheck.Value
                    )
                end
            else
                silent_aim_target = getClosestPlayerToMouse(
                    Options.SilentAimFOVRadius.Value, 
                    Options.SilentAimHitPart.Value,
                    Toggles.SilentAimWallCheck.Value,
                    Toggles.SilentAimKnockedCheck.Value,
                    Toggles.SilentAimHealthCheck.Value
                )
            end
        else
            silent_aim_target = nil
        end

        local isAimbotKeyHeld = Options.AimbotKey:GetState()
        if isAimbotKeyHeld then
            if Toggles.AimbotSticky.Value then
                if aimbot_target then
                    if not aimbot_target.Character or not aimbot_target.Character:FindFirstChild(Options.AimbotHitPart.Value) then
                        aimbot_target = nil
                    end
                end
                
                if not aimbot_target then
                    aimbot_target = getClosestPlayerToMouse(
                        Options.AimbotFOVRadius.Value, 
                        Options.AimbotHitPart.Value,
                        Toggles.AimbotWallCheck.Value,
                        Toggles.AimbotKnockedCheck.Value,
                        Toggles.AimbotHealthCheck.Value
                    )
                end
            else
                aimbot_target = getClosestPlayerToMouse(
                    Options.AimbotFOVRadius.Value, 
                    Options.AimbotHitPart.Value,
                    Toggles.AimbotWallCheck.Value,
                    Toggles.AimbotKnockedCheck.Value,
                    Toggles.AimbotHealthCheck.Value
                )
            end
        else
            aimbot_target = nil
        end

        if Toggles.AimbotEnabled and Toggles.AimbotEnabled.Value and isAimbotKeyHeld then
            local cam = Workspace.CurrentCamera
            
            if aimbot_target and aimbot_target.Character and aimbot_target.Character:FindFirstChild(Options.AimbotHitPart.Value) then
                local targetPos = getPredictionPosition(
                    aimbot_target, 
                    Options.AimbotHitPart.Value, 
                    Toggles.AimbotPrediction.Value, 
                    Options.AimbotPredictionFactor.Value, 
                    Toggles.AimbotAutoPrediction.Value
                )
                
                if targetPos then
                    local lookAt = CFrame.new(cam.CFrame.Position, targetPos)
                    local smoothing = Options.AimbotSmoothing.Value
                    
                    if smoothing > 1 then
                        cam.CFrame = cam.CFrame:Lerp(lookAt, 1 / smoothing)
                    else
                        cam.CFrame = lookAt
                    end
                end
            end
        end

        if Toggles.SilentAimShowTracer and Toggles.SilentAimShowTracer.Value and Toggles.SilentAimEnabled and Toggles.SilentAimEnabled.Value and Options.SilentAimKey:GetState() then
            if silent_aim_target and silent_aim_target.Character then
                local char = silent_aim_target.Character
                local targetPart = char:FindFirstChild(Options.SilentAimHitPart.Value) or char:FindFirstChild("HumanoidRootPart")
                
                if targetPart then
                    local screenPos, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(targetPart.Position)
                    
                    if onScreen then
                        silent_aim_tracer.Visible = true
                        silent_aim_tracer.From = game:GetService("UserInputService"):GetMouseLocation()
                        silent_aim_tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                        silent_aim_tracer.Color = Options.SilentAimTracerColor.Value
                    else
                        silent_aim_tracer.Visible = false
                    end
                else
                    silent_aim_tracer.Visible = false
                end
            else
                silent_aim_tracer.Visible = false
            end
        else
            silent_aim_tracer.Visible = false
        end
    end))

    Library:OnUnload(function()
        PerformCleanup()
    end)

    local mt = getrawmetatable(game)
    local old_index = mt.__index
    local old_newindex = mt.__newindex
    setreadonly(mt, false)

    mt.__index = function(self, index)
        if _G.CelesitalScriptRunningID ~= CurrentScriptID then
            return old_index(self, index)
        end
        
        if Toggles.SilentAimEnabled and Toggles.SilentAimEnabled.Value and Options.SilentAimKey:GetState() and self == Mouse then
            if index == "Hit" or index == "Target" then
                if silent_aim_target and silent_aim_target.Character and silent_aim_target.Character:FindFirstChild(Options.SilentAimHitPart.Value) then
                    local targetPart = silent_aim_target.Character[Options.SilentAimHitPart.Value]
                    local targetPos = getPredictionPosition(
                        silent_aim_target, 
                        Options.SilentAimHitPart.Value, 
                        Toggles.SilentAimPrediction.Value, 
                        Options.SilentAimPredictionFactor.Value, 
                        Toggles.SilentAimAutoPrediction.Value
                    )
                    
                    if index == "Hit" then
                        return CFrame.new(targetPos)
                    elseif index == "Target" then
                        return targetPart
                    end
                end
            end
        end
        
        if Toggles.BetterSpeedEnabled and Toggles.BetterSpeedEnabled.Value then
            if not checkcaller() and self:IsA("Humanoid") and index == "WalkSpeed" then
                return 16 
            end
        end
        
        return old_index(self, index)
    end

    mt.__newindex = function(self, index, value)
        if _G.CelesitalScriptRunningID ~= CurrentScriptID then
            return old_newindex(self, index, value)
        end
        

        if Toggles.BetterSpeedEnabled and Toggles.BetterSpeedEnabled.Value then
            if not checkcaller() and self:IsA("Humanoid") and index == "WalkSpeed" then
                return
            end
        end
        return old_newindex(self, index, value)
    end

    setreadonly(mt, true)

    _G.UnloadCelesital = function()
        Library:Unload()
    end

Library:Notify("Welcome to Celesital | Dahood. Press RightShift to hide / open the menu.", 5)
end)
