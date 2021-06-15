LoadFunctions()
{
    InitStates()

    SetTimer, timer, %ParmTimerDelay%

    return
}

InitStates()
{
    global

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

    return
}

GetActiveStateTest()
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