; To limit amount of running scripts
#SingleInstance Force ; Other option: [Ignore, Off]

;=============== GUI options ===================
; Specify options for the apearance of the window, change the + and -
Gui , -AlwaysOnTop +Resize -Disabled +Border +SysMenu -ToolWindow
; Set the font for all following text
Gui , Font , s30 Bold cRed
; Reset the font to standard
Gui , Font
; Add a line of text that can be changed by accessing 'TextID', this var name can be changed
Gui , Add , Text , vHelloWorldTextID , Hello world!
; Add a text field that is 400px wide and 2 rows high and read only.
Gui , Add, Edit, w400 r2 ReadOnly vHelloWorldEditID , Hello world!
; Command to show the build GUI, if not executed the window will stay hidden.
Gui , Show

; Change the text of an existing Text element by accessing its ID
GuiControl , Text , HelloWorldTextID , Goodbye world!
; When text is changed to something longer it will clip, use this to widen the field to ex 900px (This won't change the window size)
GuiControl , Move , HelloWorldTextID , w900

; Change the font of an existing element, first set a new font, then apply to elements
Gui , Font , s9 Bold cGreen
GuiControl , Font , HelloWorldTextID

;=============== Hotkeys ===================
; Ctrl  = ^
; Alt   = !
; Shift = +
; Win   = #

^!#a::
Msgbox , This is a message
Msgbox ,,, And this with auto close on 2 sec , 2
return

;=============== Usefull functions ===================
; Quickly activate a window based on his title and wait for it to become active
Activate(window_name)
{
    WinActivate , %window_name%
    WinWaitActive , %window_name%
    return
}

; Set a timer to execute a label every x milliseconds
SetTimer , TimerLabel , 1000
TimerLabel:
Msgbox ,,, Timer executed , 0.5
return

; If statement
^!#s::
if (RunStatus = "Stopped") {
    RunStatus := "Started"
} else {
    RunStatus := "Stopped"
}
Msgbox ,,, %RunStatus% , 1
return

; Get the name of the title that is currently active and save that in TitleName
WinGetTitle , TitleName , A

;=============== Default code ===================
; Win + Esc closes the AHK script
#Escape::
ExitApp
return

; Closing the GUI closes the AHK script
GuiClose:
ExitApp
return

;=============== Msgboxes ===================
; Use numbers to change buttons icons and behaviour
; 1		: OK/Cancel
; 2		: Abort/Retry/Ignore
; 3		: Yes/No/Cancel
; 4		: Yes/No
; 5		: Retry/Cancel
; 6		: Cancel/Try Again/Continue
; 16	: Icon Error
; 32	: Icon Question
; 48	: Icon Exclamation
; 64	: Icon Info
; 256	: 2nd button default
; 512	: 3rd button default
; 4096	: System Modal (always on top)

Msgbox , % 4 + 32 + 256 + 4096 , Title , Text , 2
IfMsgBox , Yes
    Msgbox , Yes
else IfMsgBox , Timeout
    Msgbox , Timeout
return

; Splash boxes can provide info without disruption
SplashTextOn ,,, Hello world!
Sleep 1000
SplashTextOn ,,, Goodbye world!
Sleep 1000
SplashTextOff
return
