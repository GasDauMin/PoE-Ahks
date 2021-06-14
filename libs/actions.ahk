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