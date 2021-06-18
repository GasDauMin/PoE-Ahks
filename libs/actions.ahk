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

Action_Numpad1(type) ; Actions: Speed combo and local teleport..
{
    global

    switch type
    {
        case 1: ; Speed combo
            MacroSpeedCombo()
            return

        case 2: ;  Local teleport (hold)
            If (ActiveProfile == 3)
            {
                Send, {MButton down}
            }
            Else
            {
                Send, {e down}
            }
            return

        case 3: ; Local teleport (release)
            If (ActiveProfile == 3)
            {
                Send, {MButton up}
            }
            Else
            {
                Send, {e up}
            }
            return
    }
    return
}

Action_Numpad2(type)
{
    If (ActiveProfile == 1)
    {
        MacroDrinkFlasks(4) ; Drink [2..5]
    }
    Else
    {
        MacroDrinkFlasks(5) ; Drink [1..5]
    }
    return
}

Action_Numpad3(type)
{
    MacroSkill(5) ; Teleport
    return
}

Action_Numpad4(type)
{
    ProfileNext()
    return
}

Action_Numpad5(type)
{
    ProfilePrev()
    return
}

Action_Numpad6(type)
{
    switch type
    {
        case 1:
            MacroInventory()
            return
        case 2:
            MacroMap()
            return
        case 3:
            return
    }
    return
}