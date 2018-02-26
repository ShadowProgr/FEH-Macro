#Persistent
#NoEnv
#SingleInstance force

CoordMode, Pixel
CoordMode, Mouse
CoordMode, ToolTip, Client

RetryTime := 5
Sleep, 3000
while (true) {
	Main()
}

Main() {
	ChooseDiff:
	DiffChosen := SelectButton("HardLV30.PNG")
	if (DiffChosen == false) {
		ExitScript()
	}
	TimedSleep(3)
	
	SelectFight:
	FightSelected := SelectButton("Fight.PNG")
	if (FightSelected == false) {
		ExitScript()
	}
	TimedSleep(3)
	
	StartAuto:
	AutoStarted := SelectButton("Auto-Battle.PNG")
	if (AutoStarted == false) {
		Goto, RestoreStamina
	}
	TimedSleep(3)
	
	ConfirmAuto:
	AutoConfirmed := SelectButton("Auto-Battle2.PNG")
	if (AutoConfirmed == false) {
		ExitScript()
	}
	TimedSleep(3)
	
	SetTimer, JustClick, 1000
	
	SelectEndingButtons(1000, 100, true)
	
	SelectEndingButtons()
	
	Goto, EndLoop
	
	RestoreStamina:
	StaminaRestored := SelectButton("Restore.PNG")
	TimedSleep(3)
	
	SelectClose:
	CloseSelected := SelectButton("Close.PNG")
	TimedSleep(3)
	Goto, StartAuto
	
	EndLoop:
}

SelectButton(ImageName, RetryTimeMulti := 2, DiffAllowed := 100) {
	Global RetryTime

	FailCount := 0

	While (FailCount != (RetryTime * RetryTimeMulti)) {
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *%DiffAllowed% %ImageName%
		if (FoundX != "" and FoundY != "") {
			MouseMove, %FoundX%, %FoundY%
			CustomClick()
			return true
		} else {
			FailCount := FailCount + 1
			ToolTip, %FailCount%, 5, 5
			TimedSleep(1)
		}
	}
	
	return false
}

SelectEndingButtons(RetryTimeMulti := 2, DiffAllowed := 100, OneTime:=false) {
	Global RetryTime
	
	FailCount := 0

	While (FailCount != (RetryTime * RetryTimeMulti)) {
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *%DiffAllowed% Close2.PNG
		if (FoundX != "" and FoundY != "") {
			SetTimer, JustClick, Off
			MouseMove, %FoundX%, %FoundY%
			CustomClick()
			TimedSleep(2)
		} else {
			ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *%DiffAllowed% OK.PNG
			if (FoundX != "" and FoundY != "") {
				SetTimer, JustClick, Off
				MouseMove, %FoundX%, %FoundY%
				CustomClick()
				if (OneTime) {
					return
				}
				TimedSleep(2)
			} else {
				FailCount := FailCount + 1
				ToolTip, %FailCount%, 5, 5
				TimedSleep(1)
			}
		}
	}
	
	return
}

CustomClick() {
	Click, down
	Sleep, 25
	Click, up
}

TimedSleep(i := 1) {
	Random, SleepTime, 400, 600
	Sleep, SleepTime * i
	return
}

ExitScript() {
	MsgBox, Exiting script at %A_Hour%:%A_Min%
	ExitApp
}

JustClick:
	CustomClick()

Esc::
	SetTimer, JustClick, Off
	ExitApp