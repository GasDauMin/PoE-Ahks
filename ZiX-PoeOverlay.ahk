#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\libs\AutoHotkey-JSON\JSON.ahk

#Include, %A_ScriptDir%\libs\global.ahk
#Include, %A_ScriptDir%\libs\actions.ahk
#Include, %A_ScriptDir%\libs\overlays.ahk
#Include, %A_ScriptDir%\libs\functions.ahk

LoadOverlays()
LoadFunctions()

return

;
; Sub-functions
;

timer:

    GuiControl, Main:, Profile, % "#" . ActiveProfile
    
    ActiveState := GetActiveState()

    switch ActiveState
    {
        case 2:
            if (ActiveOverlays)
            {
                Gui, Main:Show, NoActivate
                Gui, Misc:Show, NoActivate       
            }
            return

        case 3:
            if (ActiveOverlays)
            {
                Gui, Main:Show, NoActivate
                Gui, Misc:Hide
            }
            return

        default:
            if (ActiveOverlays)
            {
                Gui, Main:Hide
                Gui, Misc:Hide
            }
            return
    }

Return

;
; Bindings
;

#IfWinActive ahk_class POEWindowClass

    RAlt & Tab::
    {
        return
    }

    F3::
    {
        OverlayToggleShow()
        return
    }

    !Numpad1::
    {
        Action("Numpad1", 0.2) 
        return
    }

    !Numpad2::
    {
        Action("Numpad2") 
        return
    }

    !Numpad3::
    {
        Action("Numpad3",0.2) 
        return
    }

    !Numpad4::
    {
        Action("Numpad4") 
        return
    }

    !Numpad5::
    {
        Action("Numpad5") 
        return
    }

    !Numpad6::
    {
        Action("Numpad6",0.2) 
        return
    }

return

