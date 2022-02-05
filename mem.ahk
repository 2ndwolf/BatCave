Run, mspaint,,, process_id
WinWait, ahk_pid %process_id%
WinActivate, ahk_pid %process_id%
Send {Alt}
Send h
Send r
Send e
Send {Tab}
Send 1
Send {Enter}
Send ^v
Send ^s
WinWait, ahk_pid %process_id%
Send {F4}
Send {Escape}
Send D:\Desktop\Things I wrote
Send {Enter}
Send {Tab}
Send {Escape}
Send {AltDown}n{AltUp}
Send {BackSpace}