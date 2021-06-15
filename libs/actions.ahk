;
; Functions
;

Action(key,delay=0)
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
        RunAction(Format("Action_{1}",key),2)

        KeyWait, %key%
        If !ErrorLevel 
        {
            ; Long-press end action

            OutputDebug, [K#%key%] long-press <finish>
            RunAction(Format("Action_{1}",key),3)
        }
    } 
    Else 
    {
        ; Short-press action

        OutputDebug, [K#%key%] short-press
        RunAction(Format("Action_{1}",key),1)
    }
    return
}

RunAction(name,type)
{
    If (IsFunc(name))
    {
        fn := Func(name)
        fn.Call(type)
    }
    Else
    {
        OutputDebug, Try run: %name%(%type%) // Warning: function not implemented
    }
    return
}

;
; Action_*
;

Action_A(type) ; Actions: Atack..
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

Action_Numpad1(type) ; Actions: Fast run and fly..
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
            If (ActiveProfile == 1)
            {
                Send, {e down}
            }
            Else
            {
                Send, {MButton down}
            }
            return

        case 3: ; Fly
            If (ActiveProfile == 1)
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

Action_Numpad2(type) ; Actions: Drink flasks..
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

Action_Numpad3(type) ; Actions: Teleport..
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

Action_Numpad4(type) ; Actions: Next profile
{
    global

    switch type
    {
        case 1: ; Next profile
            If ActiveProfile < %ParmProfiles%
            {
                ActiveProfile++
            }           
            return
        case 2:
            return
        case 3:
            return
    }
    return
}

Action_Numpad5(type) ; Actions: Prev profile
{
    global

    switch type
    {
        case 1: ; Prev Profile
            If ActiveProfile > 1
            {
                ActiveProfile--
            }
            return
        case 2:
            return
        case 3:
            return
    }
    return
}

Action_Numpad6(type) ; Actions: Inventory and map..
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