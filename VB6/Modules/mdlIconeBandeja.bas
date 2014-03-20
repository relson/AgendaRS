Attribute VB_Name = "mdlIconeBandeja"
Option Explicit

Declare Function Shell_NotifyIcon Lib "shell32" _
         Alias "Shell_NotifyIconA" _
         (ByVal dwMessage As Long, pnid As NOTIFYICONDATA) As Boolean

Private Declare Function SHAppBarMessage Lib "shell32.dll" (ByVal dwMessage As Long, pData As APPBARDATA) As Long

Type NOTIFYICONDATA
    cbSize As Long
    hWnd As Long
    uId As Long
    uFlags As Long
    uCallbackMessage As Long
    hIcon As Long
    szTip As String * 64
End Type

Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

Type APPBARDATA
    cbSize As Long
    hWnd As Long
    uCallbackMessage As Long
    uEdge As Long
    rc As RECT
    lParam As Long
End Type

Public Const ABM_GETTASKBARPOS = &H5&

Public Const NIF_MESSAGE = &H1
Public Const NIF_ICON = &H2
Public Const NIF_TIP = &H4
Public Const WM_MOUSEMOVE = &H200

Public Const NIM_ADD = &H0
Public Const NIM_MODIFY = &H1
Public Const NIM_DELETE = &H2

Public objIconeBandeja As NOTIFYICONDATA
Public objBarData As APPBARDATA

Public Sub adicionarIconeNaBandeja(ByRef objFrm As Form, ByVal strToolTip As String)
    
    objBarData.cbSize = 36&
    
    Call SHAppBarMessage(ABM_GETTASKBARPOS, objBarData)
    
    With objIconeBandeja
        .cbSize = 88&
        .hWnd = objFrm.hWnd
        .uId = objFrm.Icon.Handle
        .uFlags = NIF_ICON Or NIF_MESSAGE Or NIF_TIP
        .uCallbackMessage = WM_MOUSEMOVE
        .hIcon = objFrm.Icon
        .szTip = strToolTip & Chr$(0)
    End With
    
    Call Shell_NotifyIcon(NIM_ADD, objIconeBandeja)
    
End Sub

Public Sub removerIconeDaBandeja()
    Unload frmIconeBandeja
    With mdiMain
        .mnuAbrir.Visible = False
        .mnuSeparador05.Visible = False
    End With
    Call Shell_NotifyIcon(NIM_DELETE, objIconeBandeja)
End Sub

Public Sub modificarIconeDaBandeja()
    objIconeBandeja.szTip = Trim(objIconeBandeja.szTip) & Chr$(0)
    Call Shell_NotifyIcon(NIM_MODIFY, objIconeBandeja)
End Sub

