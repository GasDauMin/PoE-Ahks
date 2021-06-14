#NoEnv
#SingleInstance force

SendMode Input

global Visible := false
global Profile := 1

global ParmDebug := false
global ParmProfiles := 2
global ParmPressDelay := 0.5

global GuiFont := "Segoe UI"
global GuiColorForeground := "AFAFAF"
global GuiColorBackground := "111111"
global GuiTransparency := 170
global GuiMargin := 5

global GuiProfileH := 40
global GuiProfileW := 40
global GuiProfilePosX := 740 ;KNumpad3_Action();A_ScreenWidth - GuiProfileW - 735
global GuiProfilePosY := A_ScreenHeight - GuiProfileH - 35

global GuiControlsH := 40
global GuiControlsW := 500 
global GuiControlsPosX := GuiProfilePosX + GuiProfileW + GuiMargin
global GuiControlsPosY := A_ScreenHeight - GuiControlsH - 35

;
; Actions
;

KA_Action(type) ; Actions: Atack..
{
    switch type
    {
        case 1: ; ...
            return

        case 2: ; Attack press
            Send, {MButton down}
            return

        case 3: ; Attack release
            Send, {MButton up}
            return
    }
    return
}

KNumpad1_Action(type) ; Actions: Fast run and fly..
{
    global

    switch type
    {
        case 1: ; Fast run
            Send, {q down}
            Sleep, 110
            Send, {q up}
            Sleep, 221
            Send, {w down}
            Sleep, 101
            Send, {w up}
            Sleep, 205
            Send, {2 down}
            Sleep, 105
            Send, {2 up}
            return

        case 2: ; Choose direction for flight
            If (Profile == 1)
            {
                Send, {e down}
            }
            Else
            {
                Send, {MButton down}
            }
            return

        case 3: ; Fly
            If (Profile == 1)
            {
                Send, {e up}
            }
            Else
            {
                Send, {MButton up}
            }
            return
    }
    return
}

KNumpad2_Action(type) ; Actions: Drink flasks..
{
    switch type
    {
        case 1: ; Drink flasks [2,3,4,5]
            Send, {2 down}
            Sleep, 12
            Send, {2 up}
            Sleep, 11
            Send, {3 down}
            Sleep, 10
            Send, {3 up}
            Sleep, 8
            Send, {4 down}
            Sleep, 11
            Send, {4 up}
            Sleep, 10
            Send, {5 down}
            Sleep, 11
            Send, {5 up}
            return

        case 2: ; Drink flasks [ALL]
            Send, {1 down}
            Sleep, 12
            Send, {1 up}
            Sleep, 12
            Send, {2 down}
            Sleep, 11
            Send, {2 up}
            Sleep, 10
            Send, {3 down}
            Sleep, 13
            Send, {3 up}
            Sleep, 9
            Send, {4 down}
            Sleep, 12
            Send, {4 up}
            Sleep, 10
            Send, {5 down}
            Sleep, 9
            Send, {5 up}
            return

        case 3:
            return
    }
    return
}

KNumpad3_Action(type) ; Actions: Teleport..
{
    switch type
    {
        case 1: ; Teleport
            Send, {t down}
            Sleep, 101
            Send, {t up}
            return
        case 2:
            Send, {t down}
            Sleep, 101
            Send, {t up}
            return
        case 3:
            return
    }
    return
}

KNumpad4_Action(type) ; Actions: Next Profile
{
    global

    switch type
    {
        case 1: ; Next Profile
            If Profile < %ParmProfiles%
            {
                Profile++
            }

            OutputDebug, Profile [%Profile%]
            
            return
        case 2:
            return
        case 3:
            return
    }
    return
}

KNumpad5_Action(type) ; Actions: Prev Profile
{
    global

    switch type
    {
        case 1: ; Prev Profile
            If Profile > 1
            {
                Profile--
            }

            OutputDebug, Profile [%Profile%]

            return
        case 2:
            return
        case 3:
            return
    }
    return
}

KNumpad6_Action(type) ; Actions: Inventory and map..
{
    switch type
    {
        case 1: ; Inventory
            Send, {i down}
            Sleep, 101
            Send, {i up}
            return
        case 2: ; Map
            Send, {Tab down}
            Sleep, 101
            Send, {Tab up}
            return
        case 3:
            return
    }
    return
}

;
; Functions
;

RunFunction(name,type)
{
    If (IsFunc(name))
    {
        OutputDebug, Try run: %name%(%type%)

        fn := Func(name)
        fn.Call(type)
    }
    Else
    {
        OutputDebug, Try run: %name%(%type%) // Warning: function not implemented
    }
    return
}

KeyPressAction(key,delay=0)
{
    global

    If(delay=0)
    {
        delay = %ParmPressDelay%
    }

    KeyWait, %key%, t%delay%
    If ErrorLevel 
    {
        ; Long-press start action

        OutputDebug, [K#%key%] long-press <start>

        If (!ParmDebug)
        {
            RunFunction(Format("K{1}_action",key),2)
        }

        KeyWait, %key%
        If !ErrorLevel 
        {
            ; Long-press end action

            OutputDebug, [K#%key%] long-press <finish>

            If (!ParmDebug)
            {
                RunFunction(Format("K{1}_action",key),3)
            }
        }
    } 
    Else 
    {
        ; Short-press action

        OutputDebug, [K#%key%] short-press

        If (!ParmDebug)
        {
            RunFunction(Format("K{1}_action",key),1)
        }
    }
    return
}

;
; Overlay GUIs
;

ReDraw()
{    
    GuiControl, Profile:, Profile, % "#" . Profile
    return
}

DrawProfile()
{
    global

    Gui, Profile:+E0x20 +E0x80 -DPIScale -Caption +LastFound +ToolWindow +AlwaysOnTop +hwndOverlay
    Gui, Profile:Font, c72A4DD s15 tBold, %GuiFont%
    Gui, Profile:Color, %GuiColorBackground%
    WinSet, Transparent, %GuiTransparency%

    Gui, Profile:Add, Text, x8 y4 vProfile, % "#" . Profile
    Gui, Profile:Show, x%GuiProfilePosX% y%GuiProfilePosY% w%GuiProfileW% h%GuiProfileH% NA, Gui Profile

  return
}

AddControl(idx, name, w, h, bg, fg, obj="", fx=0, fy=0)
{
    global

    If (!obj)
    {
        posX := 0
        posY := 0
    }
    Else
    {
        GuiControlGet, o, Controls:Pos, %obj%

        posX := oX + oW + GuiMargin
        posY := 0
    }

    posX := posX + fx
    posY := posY + fy

    ;

    Gui, Controls:Add, Progress, x%posX% y%posY% w%w% h%h% v%idx% Disabled Background%bg% 100
    Gui, Controls:Add, Text, xp yp wp hp c%fg% BackgroundTrans 0x201 gClicked%idx%, %name%
}

DrawControls()
{
    global

    Gui, Controls:-DPIScale -Caption +LastFound +ToolWindow +AlwaysOnTop +hwndControls
    Gui, Controls:Font, c72A4DD s12 tBold, %GuiFont%
    Gui, Controls:Color, ff0000
    WinSet, TransColor, ff0000 %GuiTransparency%

    local bg := GuiColorBackground
    local fg := GuiColorForeground

    AddControl("Overlay", "Overlay", 80, 40, bg, fg, "")

    local bg := "72A4DD"
    local fg := "111111"

    AddControl("Teleport", "T", 40, 40, "0090FF", fg, "Overlay")

    local bg := GuiColorBackground
    local fg := "FFFFFF"

    AddControl("Aura1", "M", 40, 40, bg, "0090FF", "Teleport")
    AddControl("Aura2", "H", 40, 40, bg, "30CB6E", "Aura1")
    AddControl("Aura3", "V", 40, 40, bg, "C01616", "Aura2")
    AddControl("Aura4", "E", 40, 40, bg, "9600FF", "Aura3")

    local bg := "72A4DD"
    local fg := "111111"

    AddControl("Hideout", "H", 40, 40, "9600FF", fg, "Aura4")

    Gui, Controls:Font, c72A4DD s8, %GuiFont%
    local bg := 1f1f1f
    local fg := GuiColorForeground

    AddControl("Thx1", "Thx-1", 60, 18, bg, fg, "Hideout", 0, 0)
    AddControl("Thx2", "Thx-2", 60, 18, bg, fg, "Thanks", 0, 22)

    ;;

    Gui, Controls:Show, x%GuiControlsPosX% y%GuiControlsPosY% w%GuiControlsW% h%GuiControlsH% NA, Gui Controls

    return
}

ClickedThx1()
{
    WinActivate, % "ahk_class POEWindowClass"

    Send, ^{Enter}
    Send, Thank you :)
    Send, {Enter}

    return
}

ClickedThx2()
{
    WinActivate, % "ahk_class POEWindowClass"

    Send, ^{Enter}
    Send, Thx gl :)
    Send, {Enter}

    return
}

ClickedAura1()
{
    WinActivate, % "ahk_class POEWindowClass"
    send, ^{q}
    return
}

ClickedAura2()
{
    WinActivate, % "ahk_class POEWindowClass"
    send, ^{w}
    return
}

ClickedAura3()
{
    WinActivate, % "ahk_class POEWindowClass"
    send, ^{e}
    return
}

ClickedAura4()
{
    WinActivate, % "ahk_class POEWindowClass"
    send, ^{r}
    return
}

ClickedTeleport()
{
    WinActivate, % "ahk_class POEWindowClass"
    Send, {t}
    return
}

ClickedHideout()
{
    WinActivate, % "ahk_class POEWindowClass"

    Send, {Enter}
    Send, /hideout
    Send, {Enter}

    return
}

ClickedOverlay()
{
    WinActivate, % "ahk_class POEWindowClass"

    Send, +{Space}

    return
}

InitGui()
{
    global

    DrawProfile()
    DrawControls()

    If (!Visible)
    {
        Gosub, HideAllWindows
    }

    SetTimer, ReDraw, 100

    return
}

ToggleShowGui()
{
    global

    If (Visible)
    {
        Visible := false
        Gosub, HideAllWindows
    }
    Else
    {
        Visible := true
        Gosub, ShowAllWindows
    }
}

InitGui()

return

;
; Sub-functions
;

ShowAllWindows:
  Gui, Controls:Show, NoActivate
  Gui, Profile:Show, NoActivate
return

HideAllWindows:
  Gui, Controls:Cancel
  Gui, Profile:Cancel
return

;
; Key bindings
;

#IfWinActive ahk_class POEWindowClass
RAlt & Tab::return

#IfWinActive ahk_class POEWindowClass
F3::
{
    ToggleShowGui()
    return
}

#IfWinActive ahk_class POEWindowClass
!Numpad1::
{
    KeyPressAction("Numpad1", 0.2) ;KeyPressAction("Numpad1", (Profile == 2) ? 0.001 : 0.2 ) 
    return
}

#IfWinActive ahk_class POEWindowClass
!Numpad2::
{
    KeyPressAction("Numpad2") 
    return
}

#IfWinActive ahk_class POEWindowClass
!Numpad3::
{
    KeyPressAction("Numpad3",0.2) 
    return
}

#IfWinActive ahk_class POEWindowClass
!Numpad4::
{
    KeyPressAction("Numpad4") 
    return
}

#IfWinActive ahk_class POEWindowClass
!Numpad5::
{
    KeyPressAction("Numpad5") 
    return
}

#IfWinActive ahk_class POEWindowClass
!Numpad6::
{
    KeyPressAction("Numpad6",0.2) 
    return
}
