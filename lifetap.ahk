AppTitle := "Path of Exile"
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "[%AppTitle%] not found"
    Return
}

FormatTime, CurrentDateTime, , HH:mm:ss

Key1ElcapedMSec := 9999
Key2ElcapedMSec := 9999
Key3ElcapedMSec := 9999
Key4ElcapedMSec := 9999
Key5ElcapedMSec := 9999
KeyDElcapedMSec := 9999
KeyQElcapedMSec := 9999
SetTimer, Counter, 100

SetTimer, LifeMonitor, 200

SetTimer, SendSkill, 100

Return

Counter:
    IfWinNotExist, ahk_id %UniqueID%
    {
        OutputDebug, [%CurrentDateTime%] Stopped
        ExitApp
    }
    Key1ElcapedMSec := Min(Key1ElcapedMSec + 100, 10000)
    Key2ElcapedMSec := Min(Key2ElcapedMSec + 100, 10000)
    Key3ElcapedMSec := Min(Key3ElcapedMSec + 100, 10000)
    Key4ElcapedMSec := Min(Key4ElcapedMSec + 100, 10000)
    Key5ElcapedMSec := Min(Key5ElcapedMSec + 100, 10000)
    KeyDElcapedMSec := Min(KeyDElcapedMSec + 100, 10000)
    KeyQElcapedMSec := Min(KeyQElcapedMSec + 100, 10000)
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

    if Key2ElcapedMSec >= 8000
    {
        Key2ElcapedMSec := 0
        Send, 2
        Sleep, 1000
    }
    else if Key3ElcapedMSec >= 7000
    {
        Key3ElcapedMSec := 0
        Send, 3
        Sleep, 1000
    }
    else if Key4ElcapedMSec >= 6000
    {
        Key4ElcapedMSec := 0
        Send, 4
        Sleep, 1000
    }
    else if Key5ElcapedMSec >= 5000
    {
        Key5ElcapedMSec := 0
        Send, 5
        Sleep, 1000
    }
    else if Key1ElcapedMSec >= 5000
    {
        Key1ElcapedMSec := 0
        Send, 1
        Sleep, 3000
    }

Return

SendSkill:
    IfWinNotActive, ahk_id %UniqueID%
    {
        Return
    }

    If GetKeyState("VKC0", "P") or GetKeyState("RButton", "P")
    {
        If KeyQElcapedMSec >= 1900
        {
            KeyQElcapedMSec := 0
            Send, q
        }
    }

Return

~RButton up::
    IfWinNotActive, ahk_id %UniqueID%
    {
        Return
    }

    If KeyDElcapedMSec >= 200
    {
        KeyDElcapedMSec := 0
    }

Return

^!z:: ; Control+Alt+Z hotkey.
    OutputDebug, "Z pressed"
    OutputDebug, [%CurrentDateTime%] Stopped
ExitApp