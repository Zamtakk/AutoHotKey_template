WindowTesttool := "null"
WindowExcel := "null"
RunStatus := "Stopped"
ProgStatus := "waiting"
LastID := "0x000000"

Gui , +AlwaysOnTop -Resize +Border -Disabled +SysMenu -ToolWindow
Gui , Font , s30 Bold cRed
Gui , Add , Text , vGPS_text , GPS
Gui , Add , Text , vMain_text , Main
Gui , Add , Text , vCurrent_text , Current
Gui , Font
Gui , Add, Edit, w400 r2 ReadOnly vClipboard_data
Gui , Show
SetTimer , update, 1000
return

^!#s::
    if (RunStatus = "Stopped") {
        RunStatus := "Started"
    } else {
        RunStatus := "Stopped"
    }
    Msgbox , , , %RunStatus%, 1
return

^1::
    WinGetTitle , WindowTesttool, A
return

^2::
    WinGetTitle , WindowExcel, A
return

#Escape::
    ExitApp
return

Activate(window_name)
{
    WinActivate , %window_name%
    WinWaitActive , %window_name%
    return
}

update:
    if (RunStatus = "Started" and WindowTesttool != "null" and WindowExcel != "null")
    {
        Activate(WindowTesttool)
        Send , {Enter}
        Sleep , 50
        GuiControl , Text , Clipboard_data , clipboard
        if (clipboard = "0x000000000000000`r`n"){
            if (ProgStatus != "waiting"){
                ProgStatus := "waiting"
                Gui , Font , s30 Bold cOrange
                GuiControl , Font , vGPS_text
                GuiControl , Font , vMain_text
                GuiControl , Font , vCurrent_text
            }
            Gui, show
            return
        }
        ProgStatus := "checking"
        if (LastID = clipboard){
            Gui, show
            return
        }
        Activate(WindowExcel)
        Send , {Ctrl down}f{Ctrl up}
        Activate("Find")
        Send , {Backspace}{Ctrl down}v{Ctrl up}{Enter}
        Sleep , 100
        WinGetTitle , CurWindow, A
        if (CurWindow = "Microsoft Excel") {
            Send , {Enter}
            Send , {Esc}
            Gui , Font , s30 Bold cRed
            GuiControl , Font , vGPS_text
            GuiControl , Font , vMain_text
            GuiControl , Font , vCurrent_text
            Gui, show
            return
        } else {
            Send , {Esc}
            Activate(WindowExcel)
            
            Send , {Right}{Ctrl down}c{Ctrl up}
            if (clipboard = "GPS`r`n"){
                Gui, Font , s30 Bold cGreen
                GuiControl, Font, GPS_text
            } else {
                Gui, Font , s30 Bold cRed
                GuiControl, Font, GPS_text
            }
            
            Send , {Right}{Ctrl down}c{Ctrl up}
            if (clipboard = "Main`r`n"){
                Gui, Font , s30 Bold cGreen
                GuiControl, Font, vMain_text
            } else {
                Gui, Font , s30 Bold cRed
                GuiControl, Font, vMain_text
            }
            
            Send , {Right}{Ctrl down}c{Ctrl up}
            if (clipboard = "Current`r`n"){
                Gui, Font , s30 Bold cGreen
                GuiControl, Font, vCurrent_text
            } else {
                Gui, Font , s30 Bold cRed
                GuiControl, Font, vCurrent_text
            }
        }
    }
    Gui, show
return

GuiClose:
    ExitApp
return
