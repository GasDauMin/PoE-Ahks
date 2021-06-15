global ActiveState := -1
global ActiveProfile := 1
global ActiveOverlays := true

global States := {}

global ParmDebug := false
global ParmProfiles := 2
global ParmPressDelay := 0.5
global ParmTimerDelay := 100

global ParmFont := "Segoe UI"
global ParmColorForeground := "AFAFAF"
global ParmColorBackground := "111111"
global ParmTransparency := 170
global ParmMargin := 5

global OverlayMainH := 40
global OverlayMainW := 75
global OverlayMainPosX := 740
global OverlayMainPosY := A_ScreenHeight - OverlayMainH - 35

global OverlayMiscH := 40
global OverlayMiscW := 500 
global OverlayMiscPosX := OverlayMainPosX + OverlayMainW + ParmMargin
global OverlayMiscPosY := A_ScreenHeight - OverlayMiscH - 35