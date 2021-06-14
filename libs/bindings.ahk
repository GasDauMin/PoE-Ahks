#IfWinActive ahk_class POEWindowClass

    RAlt & Tab::return

    F3::
    {
        OverlayToggleShow()
        return
    }

    !Numpad1::
    {
        KeyPressAction("Numpad1", 0.2) ;KeyPressAction("Numpad1", (Profile == 2) ? 0.001 : 0.2 ) 
        return
    }

    !Numpad2::
    {
        KeyPressAction("Numpad2") 
        return
    }

    !Numpad3::
    {
        KeyPressAction("Numpad3",0.2) 
        return
    }

    !Numpad4::
    {
        KeyPressAction("Numpad4") 
        return
    }

    !Numpad5::
    {
        KeyPressAction("Numpad5") 
        return
    }

    !Numpad6::
    {
        KeyPressAction("Numpad6",0.2) 
        return
    }

return