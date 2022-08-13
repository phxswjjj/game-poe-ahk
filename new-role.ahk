AppTitle := "Path of Exile"
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "[%AppTitle%] not found"
    Return
}

FormatTime, CurrentDateTime, , HH:mm:ss

Key1ElcapedSec := 99
Key2ElcapedSec := 99
Key3ElcapedSec := 99
Key4ElcapedSec := 99
Key5ElcapedSec := 99
SetTimer, Counter, 1000

SetTimer, LifeMonitor, 200
SetTimer, ManaMonitor, 200

SetTimer, SendSkill, 100

Return

Counter:
    IfWinNotExist, ahk_id %UniqueID%
    {
        OutputDebug, [%CurrentDateTime%] Stopped
        ExitApp
    }
    Key1ElcapedSec := Min(Key1ElcapedSec + 1, 100)
    Key2ElcapedSec := Min(Key2ElcapedSec + 1, 100)
    Key3ElcapedSec := Min(Key3ElcapedSec + 1, 100)
    Key4ElcapedSec := Min(Key4ElcapedSec + 1, 100)
    Key5ElcapedSec := Min(Key5ElcapedSec + 1, 100)
Return

LifeMonitor:
    IfWinNotActive, ahk_id %UniqueID%
    {
        Return
    }

    PixelSearch, Px, Py, 98, 925, 100, 915, 0x2719A3, 3, Fast
    if !ErrorLevel {
        Return
    }

    if Key2ElcapedSec >= 5
    {
        Key2ElcapedSec := 0
        Send, 2
        Sleep, 3000
    }
    else if Key1ElcapedSec >= 5
    {
        Key1ElcapedSec := 0
        Send, 1
        Sleep, 3000
    }

Return

ManaMonitor:
    IfWinNotActive, ahk_id %UniqueID%
    {
        Return
    }

    PixelSearch, Px, Py, 1769, 1006, 1779, 1023, 0x87420E, 3, Fast
    if !ErrorLevel {
        Return
    }
    if Key5ElcapedSec >= 5
    {
        Key5ElcapedSec := 0
        Send, 5
        Sleep, 3000
    }

Return

SendSkill:
    IfWinNotActive, ahk_id %UniqueID%
    {
        Return
    }

    If Not GetKeyState("VKC0", "P") {
        Return
    }

Return

^!z:: ; Control+Alt+Z hotkey.
    OutputDebug, "Z pressed"
    OutputDebug, [%CurrentDateTime%] Stopped
ExitApp