VERSION 5.00
Begin VB.Form frmReclassificarTipo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tipo para Reclassficar"
   ClientHeight    =   1935
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6060
   Icon            =   "frmReclassificarTipo.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   1935
   ScaleWidth      =   6060
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdCancelar 
      Caption         =   "&Cancelar"
      Height          =   375
      Left            =   3420
      TabIndex        =   3
      Top             =   1470
      Width           =   1245
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "&OK"
      Height          =   375
      Left            =   4740
      TabIndex        =   2
      Top             =   1470
      Width           =   1245
   End
   Begin VB.ComboBox cboNovoTipo 
      Height          =   315
      Left            =   150
      TabIndex        =   0
      Top             =   390
      Width           =   2205
   End
   Begin VB.Label lblMensagem 
      AutoSize        =   -1  'True
      Caption         =   "Mensagem:"
      Height          =   195
      Left            =   150
      TabIndex        =   1
      Top             =   120
      Width           =   825
   End
End
Attribute VB_Name = "frmReclassificarTipo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private mBlnCancelado As Boolean
Private mLngCodigoTipo As Long
Private mLngCodigoTipoAnterior As Long

Private Sub cboNovoTipo_KeyPress(KeyAscii As Integer)
    Call mdlUtilsCtrls.tratarKeyPressComboBox(cboNovoTipo, KeyAscii)
End Sub

Private Sub cmdCancelar_Click()
    mBlnCancelado = True
    
    Unload Me
    
End Sub

Private Sub cmdOK_Click()
    
    With cboNovoTipo
    
        If .ListIndex = -1 Then
            MsgBox "Nenhum tipo Selecionado", vbExclamation
            Exit Sub
        End If
        
        If .ItemData(.ListIndex) = mLngCodigoTipoAnterior Then
            MsgBox "Selecione um tipo diferente para poder reclassificar", vbExclamation
            Exit Sub
        End If
        
        mLngCodigoTipo = .ItemData(.ListIndex)
        
        Unload Me
        
    End With
    
End Sub

Private Sub Form_Load()
    
    Call mdlUtilsCtrls.configurarCorDeFundo(Me)
    
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    
    If UnloadMode = vbFormControlMenu Then
        mBlnCancelado = True
    End If

End Sub

Public Function Reclassificar(ByRef objTipo As ITipo) As Boolean
    
    Call mdlUtilsCtrls.configurarListaTipo(obterIndiceTipo(objTipo.Nome), cboNovoTipo)
    
    mLngCodigoTipoAnterior = objTipo.Codigo
    
    Me.Show 1
    
    objTipo.Codigo = mLngCodigoTipo
    
    Reclassificar = Not mBlnCancelado
            
End Function
