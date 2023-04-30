global config := % A_ScriptDir . "\settings.json"

global enumState := 
(LTrim Join
    {
        "Unknown": 0,
        "Play": 1 << 0, 
        "Chat": 1 << 1, 
        "LeftPanel": 1 << 2, 
        "RightPanel": 1 << 3, 
        "CenterPanel": 1 << 4,
        "Overlay": 1 << 5,
        "Stash": 1 << 6,
        "Inventory": 1 << 7,
        "Guild": 1 << 8
    }
)

global enumHealth := 
(LTrim Join
    {
        "Unknown": 0,
        "Full": 1, 
        "High": 2, 
        "Medium": 3, 
        "Low": 4
    }
)

global enumAction := 
(LTrim Join
    {
        "None": 0,
        "ShortPress": 1, 
        "LongPress": 2, 
        "LongRelease": 3
    }
)

global session := {}
global timerLock := false