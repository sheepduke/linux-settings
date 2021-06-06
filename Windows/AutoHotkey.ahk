/*
* This file is used to emulate Linux key bindings on Windows system.
*
* Some quick references:
*
*   ^ Ctrl
*   ! Alt
*   # Super
*   + Shift
*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Utilities                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IsCmdWindow() {
    return WinActive("ahk_class ConsoleWindowClass")
}

IsVirtualConsoleWindow() {
    return WinActive("ahk_class VirtualConsoleClass")
}

IsPowerShellWindow() {
    return WinActive("powershell") or WinActive("Windows PowerShell (Admin)") or WinActive("Windows PowerShell ISE")
}

IsPowerShellIseWindow() {
    return WinActive("Windows PowerShell ISE")
}

IsConsoleWindow() {
    return IsCmdWindow() or IsPowerShellWindow() or IsVirtualConsoleWindow()
}

IsOneNoteWindow() {
    SetTitleMatchMode 2
    return WinActive("OneNote")
}

IsFirefoxWindow() {
    return WinActive("ahk_class MozillaWindowClass")
}

IsEdgeWindow() {
    return WinActive("ahk_class Chrome_WidgetWin_1")
}

KillLine() {
    Send +{End}
    Send {Delete}
    return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Basic                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#if IsConsoleWindow() or IsOneNoteWindow()

; C-f => Forward char.
^F::Send {Right}
^+F::Send +{Right}

; C-b => Backward char.
^B::Send {Left}
^+B::Send +{Left}

; C-p => Backward line.
^P::Send {Up}
^+P::Send +{Up}

; C-n => Forward line.
^N::Send {Down}
^+N::Send +{Down}

; M-b => Backward word.
!B::Send ^{Left}
!+B::Send ^+{Left}

; M-f => Forward word.
!F::Send ^{Right}
!+F::Send ^+{Right}

; C-a => Goto beginning of line.
^A::Send {Home}
^+A::Send +{Home}

; C-e => Goto end of line.
^E::Send {End}
^+E::Send +{End}

; C-d => Delete char.
^D::Send {Delete}

; M-d => Delete word.
!D::Send ^{Delete}

; M-<Backspace> => Backward kill word.
!Backspace::Send ^{Backspace}

; C-g => Cancel.
^G::Send {Esc}

#if IsConsoleWindow()
^U::Send {Esc}

#if IsCmdWindow()
^K::
Send {Left}
Send +{Home}
Click right
Send {Esc}
Click right
return

#if IsPowerShellWindow()
; C-k => Kill line.
^k::KillLine()

#if IsVirtualConsoleWindow() or IsPowerShellWindow()
^K::KillLine()

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            OneNote                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#if IsOneNoteWindow() or IsPowerShellIseWindow()

^K::KillLine()
!+.::Send ^{End}
!+,::Send ^{Home}
^v::Send {PgDn}
!v::Send {PgUp}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Browser                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#if IsFirefoxWindow() or IsEdgeWindow()

!1::Send ^1
!2::Send ^2
!3::Send ^3
!4::Send ^4
!5::Send ^5
!6::Send ^6
!7::Send ^7
!8::Send ^8
!9::Send ^9

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             Global                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive

; S-q => Close window.
#q::Send !{F4}

; C-M-C => Show window class.
^!+c::
WinGetClass, class, A
MsgBox, The active window's class is "%class%".
return

; C-M-T => Show window title.
^!+t::
WinGetTitle, Title, A
MsgBox, The active window is "%Title%".
return