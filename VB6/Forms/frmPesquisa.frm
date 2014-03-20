VERSION 5.00
Begin VB.Form frmPesquisa 
   Caption         =   "Pesquisa"
   ClientHeight    =   5430
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7875
   Icon            =   "frmPesquisa.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5430
   ScaleWidth      =   7875
   StartUpPosition =   3  'Windows Default
   Begin VB.ListBox lstLista 
      Height          =   4545
      ItemData        =   "frmPesquisa.frx":0442
      Left            =   90
      List            =   "frmPesquisa.frx":0444
      TabIndex        =   2
      Top             =   750
      Width           =   7695
   End
   Begin VB.TextBox txtPesquisar 
      Height          =   285
      Left            =   90
      TabIndex        =   1
      Top             =   360
      Width           =   7695
   End
   Begin VB.Label Labels 
      AutoSize        =   -1  'True
      Caption         =   "Pesquisar:"
      Height          =   195
      Left            =   90
      TabIndex        =   0
      Top             =   90
      Width           =   735
   End
End
Attribute VB_Name = "frmPesquisa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    
    Call mdlUtilsCtrls.configurarCorDeFundo(Me)
    
End Sub

Private Sub Form_Resize()
    txtPesquisar.Width = Width - 300
    lstLista.Width = Width - 300
    lstLista.Height = Height - 1250
End Sub
Private Sub lstLista_DblClick()
    
    If lstLista.SelCount > 0 Then
        frmCadastroContato.codigoContato = CLng(lstLista.ItemData(lstLista.ListIndex))
    End If
    
    Unload Me
    
End Sub

Private Sub lstLista_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        lstLista_DblClick
    End If
End Sub

Private Sub txtPesquisar_Change()
    
    Dim strPesquisar As String
    
    Dim strSQL As String
    
    Dim strItem As String
    
    Dim rs As New ADODB.Recordset
    
    strPesquisar = Replace(txtPesquisar.Text, " ", "%")
    
    strPesquisar = Replace(strPesquisar, "'", "''")
    
    strSQL = "SELECT codigoContato, nome, sobrenome FROM Contato WHERE nome LIKE '%" & strPesquisar & "%' OR sobrenome LIKE '%" & strPesquisar & "%' GROUP BY codigoContato, nome, sobrenome"
    
    rs.CursorLocation = adUseClient
    rs.Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
    
    lstLista.Clear
    
    While Not rs.EOF
        With lstLista
        
            strItem = rs.Fields("nome").Value & " " & rs.Fields("sobrenome").Value
            
            .AddItem strItem
            
            .ItemData(.NewIndex) = rs.Fields("codigoContato").Value
            
            rs.MoveNext
        End With
    Wend
        
End Sub
