Class ClassSession {
    
    Data[]
    {
        get {
            return this._session
        }
        set {
            this._session := value
            return this._session
        }
    }

    Settings[]
    {
        get {
            return this._settings
        }
        set {
            this._settings := value
            return this._settings
        }
    }
    
    Load(file)
    {
        this.LoadSettings(file)
        this.LoadSession()
    }

    LoadSession()
    {
        this.Data := this.DeepCloneObject(this.Settings)
        this.Data.Active := {}

        this.Data.Meta := {}
        this.Data.Meta.ProfilesCount := this.Data.Profiles.Count()

        this.SetProfile(this.Data.Parameters.Profile)
    }

    LoadSettings(file)
    {
        this.Settings := {}

        Try {
            FileRead, f, %file%
            this.Settings := JSON.Load(f)
        } 
        Catch e 
        {
            MsgBox, Failed to fetch settings!`nFile: %file%`nException: %e%
            ExitApp
        }

        return this.Settings
    }


    SaveSettings(file)
    {
        Try {
            var := JSON.Dump(this.Settings,,"4")
            if (FileExist(file))
            {
                FileDelete, %file%
            }
            FileAppend, %var%, %file%
        } 
        Catch e 
        {
            MsgBox, Failed to save settings!`nFile: %file%`nException: %e%
            ExitApp
        }
    }

    DeepCloneObject(obj)
    {
        ret := obj.Clone()
        for k,v in ret  
            if IsObject(v)
                ret[k] := this.DeepCloneObject(v)
        return ret
    }

    EvaluateExpression(value)
    {
        ret := ""

        exp := value
        exp := StrReplace(exp, "{ScreenHeight}", A_ScreenHeight)
        exp := StrReplace(exp, "{ScreenWidth}", A_ScreenWidth)

        ret := Eval(exp)

        return ret[1]+0
    }

    SetProfile(index)
    {
        this.Data.Parameters.Profile := index
        this.Data.Active.Profile := this.DeepCloneObject(this.Data.Profiles[index])
    
        if (this.Data.Parameters.DevMode)
        {
            OutputDebug, % "Profile: " + session.Data.Parameters.Profile
        }  
    }

    ProfilePrev()
    {
        if (this.Data.Parameters.Profile > 1)
        {
            this.SetProfile(this.Data.Parameters.Profile-1)
        }
        return
    }

    ProfileNext()
    {
        if (this.Data.Parameters.Profile < this.Data.Meta.ProfilesCount)
        {
            this.SetProfile(this.Data.Parameters.Profile+1)
        }     
        return
    }
}