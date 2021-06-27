Action_Numpad1(type) ; Actions: Speed combo and local teleport..
{
    global session, enumAction

    switch type
    {
        case (enumAction.ShortPress): ; Speed combo
            Macro_SpeedCombo(session.Data.Active.Profile.Macro_SpeedCombo)
            return

        case (enumAction.LongPress): ;  Local teleport (hold)
            If (ActiveProfile == 3)
            {
                Send, {MButton down}
            }
            Else
            {
                Send, {e down}
            }
            return

        case (enumAction.LongRelease): ; Local teleport (release)
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
    global session
    Macro_DrinkFlasks(session.Data.Active.Profile.Macro_DrinkFlasks) ; Drink [2..5]
    return
}

Action_Numpad3(type)
{
    switch type
    {
        case 1:
            Macro_Skill(5) ; Teleport
            return
        case 2:
            Macro_Hideout() ; Hideout
            return
        case 3:
            return
    }
    return
}

Action_Numpad4(type)
{
    global session
    session.ProfileNext()
    return
}

Action_Numpad5(type)
{
    session.ProfilePrev()
    return
}

Action_Numpad6(type)
{
    switch type
    {
        case 1:
            Macro_Inventory()
            return
        case 2:
            Macro_Map()
            return
        case 3:
            return
    }
    return
}

;;

SleepRandom(a,b)
{
    Random, delay, a, b
    Sleep, delay
}

;; Macro_*

Macro_Skill(tp)
{
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

Macro_DrinkFlasks(tp = 4)
{
    if (tp == 5)
    {
        Send, {1}
        SleepRandom(25,75)
    }
    if (tp >= 4)
    {
        Send, {2}
        SleepRandom(25,75)
    }
    if (tp >= 3)
    {
        Send, {3}
        SleepRandom(25,75)
    }
    if (tp >= 2)
    {
        Send, {4}
        SleepRandom(25,75)
    }
    if (tp >= 1)
    {
        Send, {5}
        SleepRandom(25,75)
    }
    return
}

Macro_AutoHeal(key = "1", modifier = 1)
{
    Loop
    {
        Send, %key%
        SleepRandom(900*modifier,1100*modifier)
    }
}

Macro_SpeedCombo(tp = 1)
{
    Send, {q}
    SleepRandom(175,225)
    Send, {w}
    SleepRandom(175,225)

    ;; Drink speed flask

    if (tp == 2)
    {
        Send, {2}
    }

    return
}

Macro_AwkOverlay()
{
    Send, +{Space}
    return
}

Macro_ChatMessage(message)
{
    Send, {Enter}
    SleepRandom(50,100)
    Send, % " " . message
    SleepRandom(50,100)
    Send, {Enter}
    return
}

Macro_ChatWhisper(message)
{
    Send, ^{Enter}
    SleepRandom(50,100)
    Send, % " " . message
    SleepRandom(50,100)
    Send, {Enter}
    return
}

Macro_Map()
{
    Send, {Tab}
    return
}

Macro_Inventory()
{
    Send, {i}
    return
}

Macro_Hideout()
{
    Macro_ChatMessage("/hideout")
    return
}

Macro_Thanks(tp = 1)
{
    switch tp
    {
        case 1:
            Macro_ChatWhisper("Ty gl :)")
            return
        case 2:
            Macro_ChatWhisper("Thank You :)")
            return
        case 3:
            Macro_ChatWhisper("Thx :)")
            return
        case 4:
            Macro_ChatWhisper("Ty :)")
            return
    }
    return
}

Macro_ThanksRandom()
{
    Random, tp, 1, 4
    Macro_Thanks(tp)
    return
}