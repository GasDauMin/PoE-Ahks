;
; Functions
;

LoadOverlays()
{
    InitOverlayMain()
    InitOverlayMisc()    
    
    return
}

InitOverlayMain()
{
    global

    Gui, Main:-DPIScale -Caption +LastFound +ToolWindow +AlwaysOnTop +hwndOverlay
    Gui, Main:Color, %ParmColorBackground%
    Gui, Main:Color, 000000
    WinSet, TransColor, 000000

    Gui, Main:Font, cB2B2B2 s10 tBold, %ParmFont%
    Gui, Main:Add, Text, x10 y0 h%OverlayMainH% 0x200 gPress_Overlay, % "ZiX"

    Gui, Main:Font, c6B6B6B s15 tBold, %ParmFont%
    Gui, Main:Add, Text, x40 y4 h%OverlayMainH% vProfile gPress_Overlay, % "#" . ActiveProfile

    ;;

    Gui, Main:Show, Hide x%OverlayMainPosX% y%OverlayMainPosY% w%OverlayMainW% h%OverlayMainH% NA, Gui Profile

  return
}

InitOverlayMisc()
{
    global

    Gui, Misc:-DPIScale -Caption +LastFound +ToolWindow +AlwaysOnTop +hwndControls
    Gui, Misc:Font, c72A4DD s12 tBold, %ParmFont%
    Gui, Misc:Color, ff0000
    WinSet, TransColor, ff0000 %ParmTransparency%

    local bg := ParmColorBackground
    local fg := ParmColorForeground

    ;ControlAdd("Overlay", "Overlay", 80, 40, bg, fg, "")

    local bg := "72A4DD"
    local fg := "111111"

    ControlAdd("Teleport", "T", 40, 40, "0090FF", fg, "")

    local bg := ParmColorBackground
    local fg := "FFFFFF"

    ControlAdd("Aura1", "M", 40, 40, bg, "0090FF", "Teleport")
    ControlAdd("Aura2", "H", 40, 40, bg, "30CB6E", "Aura1")
    ControlAdd("Aura3", "V", 40, 40, bg, "C01616", "Aura2")
    ControlAdd("Aura4", "E", 40, 40, bg, "9600FF", "Aura3")

    local bg := "72A4DD"
    local fg := "111111"

    ControlAdd("Hideout", "H", 40, 40, "9600FF", fg, "Aura4")

    Gui, Misc:Font, c72A4DD s8, %ParmFont%
    local bg := 1f1f1f
    local fg := ParmColorForeground

    ControlAdd("Thx1", "Thx-1", 60, 18, bg, fg, "Hideout", 0, 0)
    ControlAdd("Thx2", "Thx-2", 60, 18, bg, fg, "Hideout", 0, 22)

    ;;

    Gui, Misc:Show, Hide x%OverlayMiscPosX% y%OverlayMiscPosY% w%OverlayMiscW% h%OverlayMiscH% NA, Gui Controls
    
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
        GuiControlGet, o, Misc:Pos, %obj%

        posX := oX + oW + ParmMargin
        posY := 0
    }

    posX := posX + fx
    posY := posY + fy

    ;

    Gui, Misc:Add, Progress, x%posX% y%posY% w%w% h%h% v%idx% Disabled Background%bg% 100
    Gui, Misc:Add, Text, xp yp wp hp c%fg% BackgroundTrans 0x201 gPress_%idx%, %name%
}

OverlayToggleShow()
{
    global

    If (ActiveOverlays)
    {
        ActiveOverlays := false
        OverlayHide()
    }
    Else
    {
        ActiveOverlays := true
        OverlayShow()
    }
}

OverlayHide()
{
    Gui, Main:Hide
    Gui, Misc:Hide
}

OverlayShow()
{
    Gui, Main:Show, NoActivate
    Gui, Misc:Show, NoActivate
}

;
; Events
;

Press_Overlay()
{
    WinActivate, % "ahk_class POEWindowClass"

    Send, +{Space}

    return
}

Press_Thx1()
{
    WinActivate, % "ahk_class POEWindowClass"  

    Send, ^{Enter}
    Send, Thank you :)
    Send, {Enter}

    return
}

Press_Thx2()
{
    WinActivate, % "ahk_class POEWindowClass"

    Send, ^{Enter}
    Send, Thx gl :)
    Send, {Enter}

    return
}

Press_Aura1()
{
    WinActivate, % "ahk_class POEWindowClass"
    send, ^{q}
    return
}

Press_Aura2()
{
    WinActivate, % "ahk_class POEWindowClass"
    send, ^{w}
    return
}

Press_Aura3()
{
    WinActivate, % "ahk_class POEWindowClass"
    send, ^{e}
    return
}

Press_Aura4()
{
    WinActivate, % "ahk_class POEWindowClass"
    send, ^{r}
    return
}

Press_Teleport()
{
    WinActivate, % "ahk_class POEWindowClass"
    Send, {t}
    return
}

Press_Hideout()
{
    WinActivate, % "ahk_class POEWindowClass"

    Send, {Enter}
    Send, /hideout
    Send, {Enter}

    return
}