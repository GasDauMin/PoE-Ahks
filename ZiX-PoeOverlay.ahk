#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include, %A_ScriptDir%\libs\global.ahk
#Include, %A_ScriptDir%\libs\actions.ahk
#Include, %A_ScriptDir%\libs\overlay.ahk

Draw()

#Include, %A_ScriptDir%\libs\bindings.ahk
