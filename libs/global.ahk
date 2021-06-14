global Visible := true
global Profile := 1
global State := 0

global ParmDebug := false
global ParmProfiles := 2
global ParmPressDelay := 0.5

global GuiFont := "Segoe UI"
global GuiColorForeground := "AFAFAF"
global GuiColorBackground := "111111"
global GuiTransparency := 170
global GuiMargin := 5
global GuiRefresh := 100

global GuiProfileH := 40
global GuiProfileW := 40
global GuiProfilePosX := 740 ;KNumpad3_Action();A_ScreenWidth - GuiProfileW - 735
global GuiProfilePosY := A_ScreenHeight - GuiProfileH - 35

global GuiControlsH := 40
global GuiControlsW := 500 
global GuiControlsPosX := GuiProfilePosX + GuiProfileW + GuiMargin
global GuiControlsPosY := A_ScreenHeight - GuiControlsH - 35