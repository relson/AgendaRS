VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmPreferencias 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Preferências"
   ClientHeight    =   6780
   ClientLeft      =   2565
   ClientTop       =   1500
   ClientWidth     =   5925
   Icon            =   "frmPreferencias.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6780
   ScaleWidth      =   5925
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame2 
      Caption         =   "Cor de Fundo"
      Enabled         =   0   'False
      Height          =   945
      Left            =   120
      TabIndex        =   12
      Top             =   870
      Visible         =   0   'False
      Width           =   3075
      Begin VB.CheckBox Check1 
         Caption         =   "Padrão"
         Height          =   195
         Left            =   1320
         TabIndex        =   14
         Top             =   420
         Width           =   1245
      End
      Begin VB.TextBox Text1 
         Height          =   615
         Left            =   120
         Locked          =   -1  'True
         TabIndex        =   13
         Top             =   210
         Width           =   855
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Caminho do arquivo de Banco de dados"
      Height          =   615
      Left            =   90
      TabIndex        =   9
      Top             =   120
      Width           =   5685
      Begin VB.TextBox txtCaminhoArquivoBanco 
         Height          =   285
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   4845
      End
      Begin VB.CommandButton cmdProcurar 
         Caption         =   "..."
         Height          =   345
         Left            =   5070
         TabIndex        =   10
         Top             =   210
         Width           =   435
      End
   End
   Begin MSComDlg.CommonDialog cmnDlg 
      Left            =   5040
      Top             =   1740
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.PictureBox picOptions 
      BorderStyle     =   0  'None
      Height          =   3780
      Index           =   3
      Left            =   -20000
      ScaleHeight     =   3780
      ScaleWidth      =   5685
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   480
      Width           =   5685
      Begin VB.Frame fraSample4 
         Caption         =   "Sample 4"
         Height          =   1785
         Left            =   2100
         TabIndex        =   8
         Top             =   840
         Width           =   2055
      End
   End
   Begin VB.PictureBox picOptions 
      BorderStyle     =   0  'None
      Height          =   3780
      Index           =   2
      Left            =   -20000
      ScaleHeight     =   3780
      ScaleWidth      =   5685
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   480
      Width           =   5685
      Begin VB.Frame fraSample3 
         Caption         =   "Sample 3"
         Height          =   1785
         Left            =   1545
         TabIndex        =   7
         Top             =   675
         Width           =   2055
      End
   End
   Begin VB.PictureBox picOptions 
      BorderStyle     =   0  'None
      Height          =   3780
      Index           =   1
      Left            =   -20000
      ScaleHeight     =   3780
      ScaleWidth      =   5685
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   480
      Width           =   5685
      Begin VB.Frame fraSample2 
         Caption         =   "Sample 2"
         Height          =   1785
         Left            =   645
         TabIndex        =   6
         Top             =   300
         Width           =   2055
      End
   End
   Begin VB.CommandButton cmdApply 
      Caption         =   "A&plicar"
      Height          =   375
      Left            =   4710
      TabIndex        =   2
      Top             =   6285
      Width           =   1095
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   375
      Left            =   3510
      TabIndex        =   1
      Top             =   6300
      Width           =   1095
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "&OK"
      Height          =   375
      Left            =   2280
      TabIndex        =   0
      Top             =   6285
      Width           =   1095
   End
End
Attribute VB_Name = "frmPreferencias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
 
Private tbsOptions As TabStrip
 
Const COR_FUNDO_PADRAO = &H8000000F

Private Sub Check1_Click()
    
    If CBool(Check1.Value) Then Me.Text1.BackColor = COR_FUNDO_PADRAO
    
End Sub

Private Sub cmdApply_Click()
    
    If Dir(Me.txtCaminhoArquivoBanco.Text) <> "" Then
        SaveSetting App.EXEName, "preferencias", "caminho_banco_dados", txtCaminhoArquivoBanco.Text
        Call mdlAcessoDados.reconectar
    Else
        MsgBox "Não foi possível encontrar o arquivo " & vbCrLf & Me.txtCaminhoArquivoBanco.Text, vbCritical
    End If
    
    SaveSetting App.EXEName, "preferencias", "cor_fundo", Text1.BackColor
    
    cmdApply.Enabled = False
    
End Sub

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdOK_Click()

    cmdApply_Click

    Unload Me
End Sub

Private Sub cmdProcurar_Click()
    
    On Error GoTo Trata_Erro
    
    With cmnDlg
    
        .CancelError = True
        
        .Filter = "Banco de Dados AgendaRS db.mdb | db.mdb"
        
        .ShowOpen
        
        txtCaminhoArquivoBanco.Text = .FileName
    
    End With
    
    Exit Sub
    
Trata_Erro:
    
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim i As Integer
    'handle ctrl+tab to move to the next tab
    If Shift = vbCtrlMask And KeyCode = vbKeyTab Then
        i = tbsOptions.SelectedItem.Index
        If i = tbsOptions.Tabs.Count Then
            'last tab so we need to wrap to tab 1
            Set tbsOptions.SelectedItem = tbsOptions.Tabs(1)
        Else
            'increment the tab
            Set tbsOptions.SelectedItem = tbsOptions.Tabs(i + 1)
        End If
    End If
End Sub

Private Sub Form_Load()
    
    Call mdlUtilsCtrls.configurarCorDeFundo(Me)
    
    'center the form
    Me.Move (Screen.Width - Me.Width) / 2, (Screen.Height - Me.Height) / 2
    
    Me.txtCaminhoArquivoBanco.Text = GetSetting(App.EXEName, "preferencias", "caminho_banco_dados", App.Path & "\db\db.mdb")
    Me.Text1.BackColor = GetSetting(App.EXEName, "preferencias", "cor_fundo", COR_FUNDO_PADRAO)
    
End Sub

Private Sub tbsOptions_Click()
    
    Dim i As Integer
    'show and enable the selected tab's controls
    'and hide and disable all others
    For i = 0 To tbsOptions.Tabs.Count - 1
        If i = tbsOptions.SelectedItem.Index - 1 Then
            
        Else
            
        End If
    Next
    
End Sub

Public Property Get corFundoPadrao() As Long
    corFundoPadrao = COR_FUNDO_PADRAO
End Property

Private Sub Text1_Click()
    With cmnDlg
        .ShowColor
        Text1.BackColor = .Color
    End With
End Sub
