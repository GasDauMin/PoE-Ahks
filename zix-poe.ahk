; #InstallKeybdHook
; #InstallMouseHook

#SingleInstance, Force
CoordMode Pixel
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\libs\AhkJson\JSON.ahk
#Include %A_ScriptDir%\libs\AhkEval\Eval.ahk

;;
;; Includes
;;

#Include %A_ScriptDir%\libs\global.ahk
#Include %A_ScriptDir%\libs\session.ahk
#Include %A_ScriptDir%\libs\functions.ahk
#Include %A_ScriptDir%\libs\actions.ahk

;;
;; Main
;; 

session := new ClassSession()
session.Load(config)

SetTimer, timer, % session.Data.Parameters.TimerDelay

timer:

    if (timerLock)
    {
        return
    }

    timerLock := true

    lastState := session.data.Active.State
    session.data.Active.State := GetState()

    if (lastState != session.data.Active.State && session.Data.Parameters.DevMode)
    {
        OutputDebug, % Format("State: {1} = {2}", ConvertBase(10, 2, session.data.Active.State,9), session.data.Active.State, lastState)
    }

    timerLock := false
    
Return

;;
;; Bindings only for [play] actions
;;

#If IsActive() and IsPlayState()

    Numpad1::
    {
        action("Numpad1")
        return
    }

    Numpad2::
    {
        action("Numpad2")
        return
    }

    Numpad3::
    {
        action("Numpad3")
        return
    }

    Numpad4::
    {
        action("Numpad4")
        return
    }

    Numpad5::
    {
        action("Numpad5")
        return
    }

    Numpad6::
    {
        action("Numpad6")
        return
    }

return

;;
;; Bindings (game wide)
;;

#If IsActive()

    RAlt & Tab::
    {
        return
    }

return