GetActiveState()
{
    global 

    if (!WinActive("ahk_class POEWindowClass") 
    &&  !WinActive("ahk_exe i_view64.exe"))
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

ProfilePrev()
{
    global
    If ActiveProfile > 1
    {
        ActiveProfile--
    }
    return
}

ProfileNext()
{
    global
    If ActiveProfile < %ParmProfiles%
    {
        ActiveProfile++
    }           

    return
}

MacroSkill(tp)
{
    WinActivate, % "ahk_class POEWindowClass"

    switch tp
    {
        case 1:
            send, {q}
            return
        case 2:
            send, {w}
            return
        case 3:
            send, {e}
            return
        case 4:
            send, {r}
            return
        case 5:
            send, {t}
            return
        case 6: 
            send, ^{q}
            return
        case 7:
            send, ^{w}
            return
        case 8:
            send, ^{e}
            return
        case 9:
            send, ^{r}
            return
        case 10:
            send, ^{t}
            return
    }

    return
}

MacroDrinkFlasks(tp = 4)
{
    WinActivate, % "ahk_class POEWindowClass"

    if (tp == 5)
    {
        Send, {1}
    }
    if (tp >= 4)
    {
        Send, {2}
    }
    if (tp >= 3)
    {
        Send, {3}
    }
    if (tp >= 2)
    {
        Send, {4}
    }
    if (tp >= 1)
    {
        Send, {5}
    }

    return
}

MacroSpeedCombo()
{
    WinActivate, % "ahk_class POEWindowClass"

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
}

MacroAwkOverlay()
{
    WinActivate, % "ahk_class POEWindowClass"
    Send, +{Space}
    return
}

MacroMap()
{
    WinActivate, % "ahk_class POEWindowClass"
    Send, {Tab}
    return
}

MacroInventory()
{
    WinActivate, % "ahk_class POEWindowClass"
    Send, {i}
    return
}

MacroChatMessage(message)
{
    WinActivate, % "ahk_class POEWindowClass"

    Send, {Enter}
    Send, % " " . message
    Send, {Enter}

    return
}

int2hex(int)
{
    HEX_INT := 8
    while (HEX_INT--)
    {
        n := (int >> (HEX_INT * 4)) & 0xf
        h .= n > 9 ? chr(0x37 + n) : n
        if (HEX_INT == 0 && HEX_INT//2 == 0)
            h .= " "
    }
    return "0x" h
}

Test_InitStates()
{
    global

    /*
    local file := "libs\states.json"
    if (!FileExist(file))
        return

    Try {
        States := {}
        FileRead, JsonFile, %file%
        States := JSON.Load(JsonFile)
    } Catch e {
        MsgBox, 16, , % e "JSON parsing error"
        ExitApp
    }
    */

    return
}

Test_GetActiveState()
{
    global

    /*
    ActiveStateN := ""

    if (!WinActive("ahk_class POEWindowClass") 
    &&  !WinActive("ahk_exe i_view64.exe"))
    {
        return
    }

    For key_1, state in States {

        stateTest := Array()
        stateName := state.Name
        stateRule := state.Rule

        For key_2, point in state.Pixels {

            PixelGetColor, tp, point.x, point.y, RGB
            c := int2hex(tp)
            stateTest.Push(point.color == tp)
        }

        ;;

        if (stateTest)
        {
            ActiveStateN := stateName
        }
    }
    */

    return
}