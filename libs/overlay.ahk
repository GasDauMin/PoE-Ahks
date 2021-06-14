;
; Functions
;

Timer()
{   
    global

    GuiControl, Profile:, Profile, % "#" . Profile

    ;;

    state := GetCurrentState()
    
    switch state
    {
        case 2:
            if (visible)
            {
                OverlayShow()
            }
            return

        case 3:
            if (visible)
            {
                OverlayHide()
            }
            return

        default:
            if (visible)
            {
                OverlayHide()
            }
            return
    }

    return
}

GetCurrentState()
{
    if (!WinActive("ahk_class POEWindowClass"))
    {
        return 0
    }

    ; Test control pixels

    PixelGetColor, cp_1, 323, 1392 
    PixelGetColor, cp_2, 382, 1395
    PixelGetColor, cp_3, 882, 1407
    PixelGetColor, cp_4, 882, 8

    if (cp_1 == 0x4080B3 || cp_2 == 0x4080B3) 
    {
        if (cp_3 == 0x2E364C || cp_4 == 0x2E364C) 
        {
            return 3 ; Left panel open
        }

        return 2 ; Playing game
    }

    return 1 ; Game started (login screen, loading screen, etc.)
}

Draw()
{
    global

    DrawProfile()
    DrawControls()

    If (!Visible)
    {
        OverlayHide()
    }

    SetTimer, Timer, %GuiRefresh%

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

DrawControls()
{
    global

    Gui, Controls:-DPIScale -Caption +LastFound +ToolWindow +AlwaysOnTop +hwndControls
    Gui, Controls:Font, c72A4DD s12 tBold, %GuiFont%
    Gui, Controls:Color, ff0000
    WinSet, TransColor, ff0000 %GuiTransparency%

    local bg := GuiColorBackground
    local fg := GuiColorForeground

    ControlAdd("Overlay", "Overlay", 80, 40, bg, fg, "")

    local bg := "72A4DD"
    local fg := "111111"

    ControlAdd("Teleport", "T", 40, 40, "0090FF", fg, "Overlay")

    local bg := GuiColorBackground
    local fg := "FFFFFF"

    ControlAdd("Aura1", "M", 40, 40, bg, "0090FF", "Teleport")
    ControlAdd("Aura2", "H", 40, 40, bg, "30CB6E", "Aura1")
    ControlAdd("Aura3", "V", 40, 40, bg, "C01616", "Aura2")
    ControlAdd("Aura4", "E", 40, 40, bg, "9600FF", "Aura3")

    local bg := "72A4DD"
    local fg := "111111"

    ControlAdd("Hideout", "H", 40, 40, "9600FF", fg, "Aura4")

    Gui, Controls:Font, c72A4DD s8, %GuiFont%
    local bg := 1f1f1f
    local fg := GuiColorForeground

    ControlAdd("Thx1", "Thx-1", 60, 18, bg, fg, "Hideout", 0, 0)
    ControlAdd("Thx2", "Thx-2", 60, 18, bg, fg, "Thanks", 0, 22)

    ;;

    Gui, Controls:Show, x%GuiControlsPosX% y%GuiControlsPosY% w%GuiControlsW% h%GuiControlsH% NA, Gui Controls

    return
}

ControlAdd(idx, name, w, h, bg, fg, obj="", fx=0, fy=0)
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

OverlayHide()
{
    Gui, Controls:Cancel
    Gui, Profile:Cancel
}

OverlayShow()
{
    Gui, Controls:Show, NoActivate
    Gui, Profile:Show, NoActivate
}

OverlayToggleShow()
{
    global

    If (Visible)
    {
        Visible := false
        OverlayHide()
    }
    Else
    {
        Visible := true
        OverlayShow()
    }
}

;
; Events
;

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