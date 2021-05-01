ThankTheTank = {}

local guards = {}

local function ui()
    local counter = 1
    for name,amount in pairs(guards) do
        local window = "ThankTheTank"..name
        if not DoesWindowExist(window) then
            CreateWindowFromTemplate(window, "ThankTheTankTemplate", "Root")
            WindowSetShowing(window, true)
            LabelSetText(window.."Name", towstring(name))
        end
        LabelSetText(window.."Points", towstring(amount))
        WindowClearAnchors(window)
        WindowAddAnchor(window, "topleft", "ThankTheTank", "topleft", 0, counter * 30)
        counter = counter + 1
    end
end

function ThankTheTank.OnInitialize()
    RegisterEventHandler( SystemData.Events.WORLD_OBJ_COMBAT_EVENT, "ThankTheTank.OnCombatAction")
    CreateWindow("ThankTheTank", true)
    WindowSetShowing("ThankTheTank", false)
    LabelSetText("ThankTheTank", L"Thank The Tank")
    LayoutEditor.RegisterWindow("ThankTheTank", L"ThankTheTank", L"Thank The Tank", false, false, false)
end

function ThankTheTank.OnCombatAction(hitTargetObjectNumber, hitAmount, textType)
    if GameData.Player.worldObjNum == hitTargetObjectNumber then
        if textType == GameData.CombatEvent.HIT or textType == GameData.CombatEvent.ABILITY_HIT or textType == GameData.CombatEvent.CRITICAL or textType == GameData.CombatEvent.ABILITY_CRITICAL then
            if hitAmount < 0 then
                guard = {name="",distance=999}
                for name, guarder in pairs(LibGuard.registeredGuards) do
                    if guarder.distance <= 30 and guarder.distance < guard.distance then
                        guard.name=name
                        guard.distance=guarder.distance
                    end 
                end
                if guard.name ~= "" then
                    guards[guard.name] = guards[guard.name] or 0
                    guards[guard.name] = guards[guard.name] - hitAmount
                    WindowSetShowing("ThankTheTank", true)
                    ui()
                end
            end
        end
    end
end
function ThankTheTank.OnLButtonUp()
    local mouseWin = SystemData.MouseOverWindow.name
    local name = mouseWin:match("^ThankTheTank(.+)$")
    if not name or not guards[name] then
        return
    end
    SendChatText(towstring("/w "..name.." Thanks for saving me from about "..tostring(guards[name]).." damage."), L"")
    guards[name] = nil
    DestroyWindow(mouseWin)
    ui()
end
function ThankTheTank.OnRButtonUp()
    local mouseWin = SystemData.MouseOverWindow.name
    local name = mouseWin:match("^ThankTheTank(.+)$")
    if not name or not guards[name] then
        return
    end
    guards[name] = nil
    DestroyWindow(mouseWin)
    ui()
end