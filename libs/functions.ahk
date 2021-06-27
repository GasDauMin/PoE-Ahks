;; Helpers

IsActive()
{
    global session

    if (!session.Data.Parameters.RestrictedMode)
    {
        return true
    }
    
    return WinActive("ahk_class POEWindowClass")
}

IsPlayState(allowOtherStates = false)
{
    global session

    if (allowOtherStates)
    {
        return HasFlag(session.data.Active.State,enumState.Play)
    }
    else
    {
        return IsFlag(session.data.Active.State,enumState.Play)
    }  
}

IsInventoryState(checkHero = true, checkStash = true, checkGuild = true)
{
    global session

    if (checkHero)
    {
        if (HasFlag(session.data.Active.State,enumState.Inventory))
            return true
    }

    if (checkStash)
    {
        if (HasFlag(session.data.Active.State,enumState.Stash))
            return true
    }

    if (checkGuild)
    {
        if (HasFlag(session.data.Active.State,enumState.Guild))
            return true
    }

    return false
}

;; Actions

Action(key,delay="")
{
    global session, enumAction

    fn := Format("Action_{1}",key)

    if(delay=="")
    {
        delay := session.Data.Active.Profile[fn . "_PressDelay"]
        if(delay=="")
        {
            delay := session.Data.Parameters.PressDelay
        }
    }

    KeyWait, %key%, t%delay%
    If ErrorLevel 
    {
        RunAction(fn, enumAction.LongPress)

        ;; Wait for release..

        KeyWait, %key%
        If !ErrorLevel 
        {
            RunAction(fn, enumAction.LongRelease)
        }
    } 
    Else 
    {
        RunAction(fn, enumAction.ShortPress)
    }
    return
}

RunAction(name,type)
{
    global session

    If (IsFunc(name))
    {
        if (session.Data.Parameters.DevMode)
        {
            OutputDebug, Call: %name%(%type%)
        }

        fn := Func(name)
        fn.Call(type)
    }
    Else
    {
        if (session.Data.Parameters.DevMode)
        {
            OutputDebug, Function not implemented: %name%(%type%)
        }
    }
    return
}

;; General

GetState()
{
    global session, state
    
    ;; Set [unknown] state

    ret := enumState.Unknown

    ;; Check for [play] state

    PixelGetColor, cp_1, 323, 1391
    PixelGetColor, cp_2, 382, 1394

    if (cp_1 == 0x4080B3 || cp_2 == 0x4080B3)
    {
        ret := ret | enumState.Play

        ;; Check for [chat] state

        PixelGetColor, cp_3, 906, 518
        PixelGetColor, cp_4, 924, 537

        if (cp_3 == 0xDFECF2 && cp_4 == 0x122155)
        {
            ret := ret | enumState.Chat
        }

        ;; Check for [LeftPanel] state

        PixelGetColor, cp_3, 882, 9
        PixelGetColor, cp_4, 882, 1407

        if (cp_3 == 0x2E364C || cp_4 == 0x2E364C)
        {
            ret := ret | enumState.LeftPanel

            ;; Check for [Stash] state

            ; ImageSearch, ci_x, ci_y, 0, 0, A_ScreenWidth, A_ScreenHeight, % A_ScriptDir . "\img\ci_stash.png"
            ; if (ErrorLevel = 0)
            ; {
            ;     ret := ret | enumState.Stash
            ; }
            ; else
            ; {
            ;     ImageSearch, ci_x, ci_y, 0, 0, A_ScreenWidth, A_ScreenHeight, % A_ScriptDir . "\img\ci_stash_1.png"
            ;     if (ErrorLevel = 0)
            ;     {
            ;         ret := ret | enumState.Stash
            ;     }
            ; }

            ;; Check for [Guild] state

            ; ImageSearch, ci_x, ci_y, 0, 0, A_ScreenWidth, A_ScreenHeight, % A_ScriptDir . "\img\ci_guild.png"
            ; if (ErrorLevel = 0)
            ; {
            ;     ret := ret | enumState.Guild
            ; }
        }

        ;; Check for [RightPanel] state

        PixelGetColor, cp_3, 1674, 9
        PixelGetColor, cp_4, 1674, 1407

        if (cp_3 == 0x323C53 || cp_4 == 0x323C53)
        {
            ret := ret | enumState.RightPanel

            ;; Check for [Inventory] state

            ; ImageSearch, ci_x, ci_y, 0, 0, A_ScreenWidth, A_ScreenHeight, % A_ScriptDir . "\img\ci_inventory.png"
            ; if (ErrorLevel = 0)
            ; {
            ;     ret := ret | enumState.Inventory
            ; }
            ; else
            ; {
            ;     ImageSearch, ci_x, ci_y, 0, 0, A_ScreenWidth, A_ScreenHeight, % A_ScriptDir . "\img\ci_inventory_1.png"
            ;     if (ErrorLevel = 0)
            ;     {
            ;         ret := ret | enumState.Inventory
            ;     }
            ; }
        }

        ;; Check for [Overlay] state

        PixelGetColor, cp_3, 1229, 3
        PixelGetColor, cp_4, 1346, 3

        if (cp_3 == 0x081312 || cp_4 == 0x081312)
        {
            ret := ret | enumState.Overlay
        }

        ;; Check for [CenterPanel] state

        ; ImageSearch, ci_x, ci_y, 950, 20, 2500, 1000, % A_ScriptDir . "\img\ci_dialog_A.png"
        ; if (ErrorLevel = 0)
        ; {
        ;     ret := ret | enumState.CenterPanel
        ; }
        ; else
        ; {
        ;     ImageSearch, ci_x, ci_y, 950, 20, 2500, 1000, % A_ScriptDir . "\img\ci_dialog_B.png"
        ;     if (ErrorLevel = 0)
        ;     {
        ;         ret := ret | enumState.CenterPanel
        ;     }
        ; }
    }

    return ret
}

;;

ConvertBase(inputBase, outputBase, value, offset = 0)  ; Base 2 - 36
{
    static u := A_IsUnicode ? "_wcstoui64" : "_strtoui64"
    static v := A_IsUnicode ? "_i64tow"    : "_i64toa"
    VarSetCapacity(ret, 66, 0)
    res := DllCall("msvcrt.dll\" u, "Str", value, "UInt", 0, "UInt", inputBase, "CDECL Int64")
    DllCall("msvcrt.dll\" v, "Int64", res, "Str", ret, "UInt", outputBase, "CDECL")
    if (offset != 0)
    {
        delta := offset - strLen(ret)
        while(delta > 0)
        {
            delta--
            ret := % "0" . ret
        }
    }
    return ret
}

IsFlag(value, flag)
{
    return value == flag
}

HasFlag(value, flag)
{
    return (value & flag) == flag
}
