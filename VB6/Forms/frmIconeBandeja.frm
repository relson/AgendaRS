VERSION 5.00
Begin VB.Form frmIconeBandeja 
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "frmIconeBandeja"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' Constantes para tratamento de evento do mouse ao clicar no Ícone da Bandeja
Private Const WM_LBUTTONDBLCLK = &H203
Private Const WM_LBUTTONDOWN = &H201
Private Const WM_LBUTTONUP = &H202

Private Const WM_RBUTTONDBLCLK = &H206
Private Const WM_RBUTTONDOWN = &H204
Private Const WM_RBUTTONUP = &H205



Private Sub Form_Load()
    
    mdiMain.mnuAbrir.Visible = True
    mdiMain.mnuSeparador05.Visible = True
    
    Me.Icon = mdiMain.Icon
    
    Me.Caption = mdiMain.Caption
    
    Call mdlIconeBandeja.adicionarIconeNaBandeja(Me, Me.Caption)
    
    Me.Hide
     
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    
    Dim msg As Long
    Dim sFilter As String
       
    On Error Resume Next
    
    If Me.ScaleMode <> 3 Then
        msg = X / Screen.TwipsPerPixelX
    Else
         msg = X
    End If
        
    Select Case msg
        Case WM_LBUTTONDOWN

        Case WM_LBUTTONUP
        
        Case WM_LBUTTONDBLCLK
            
        Case WM_RBUTTONDOWN
        
        Case WM_RBUTTONUP
            Call PopupMenu(mdiMain.mnuArquivo)
        Case WM_RBUTTONDBLCLK
            
    End Select
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    
    Call mdlIconeBandeja.removerIconeDaBandeja
    
End Sub
