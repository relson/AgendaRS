VERSION 5.00
Begin VB.Form frmCadastroTipos 
   Caption         =   "Cadastro - Tipos"
   ClientHeight    =   2865
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4590
   Icon            =   "frmCadastroTipos.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   2865
   ScaleWidth      =   4590
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cmdExcluir 
      Caption         =   "E&xcluir"
      Height          =   345
      Left            =   3180
      TabIndex        =   6
      Top             =   1170
      Width           =   1245
   End
   Begin VB.CommandButton cmdEditar 
      Caption         =   "&Editar"
      Height          =   345
      Left            =   3180
      TabIndex        =   5
      Top             =   780
      Width           =   1245
   End
   Begin VB.CommandButton cmdCadastrar 
      Caption         =   "&Incluir"
      Height          =   345
      Left            =   3180
      TabIndex        =   3
      Top             =   270
      Width           =   1245
   End
   Begin VB.CommandButton cmdSair 
      Caption         =   "&Sair"
      Height          =   345
      Left            =   3180
      TabIndex        =   2
      ToolTipText     =   "Sair ou Cancelar a Operação Atual"
      Top             =   2460
      Width           =   1245
   End
   Begin VB.TextBox txtDescricao 
      Height          =   285
      Left            =   60
      MaxLength       =   80
      TabIndex        =   1
      Top             =   300
      Width           =   3015
   End
   Begin VB.ListBox lstTipos 
      Height          =   2010
      ItemData        =   "frmCadastroTipos.frx":014A
      Left            =   60
      List            =   "frmCadastroTipos.frx":014C
      TabIndex        =   0
      Top             =   780
      Width           =   3015
   End
   Begin VB.Label Labels 
      AutoSize        =   -1  'True
      Caption         =   "&Descrição:"
      Height          =   195
      Index           =   3
      Left            =   90
      TabIndex        =   4
      Top             =   30
      Width           =   765
   End
End
Attribute VB_Name = "frmCadastroTipos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Enum ETipos
    etpContato = 0
    etpEmail = 1
End Enum

Implements IToolBarControles

Private mStrNomeTipo As String
Private mEtpTipo As ETipos

Public Property Let NomeTipo(ByVal strNomeTipo As String)
    mStrNomeTipo = strNomeTipo
    
    Me.Caption = "Cadastro - Tipo de " & strNomeTipo
    
End Property

Public Property Get NomeTipo() As String
    mStrNomeTipo = NomeTipo
End Property

Public Property Let Tipo(ByVal etpTipo As ETipos)
    mEtpTipo = etpTipo
    AtualizaLista
End Property

Public Property Get Tipo() As ETipos
    Tipo = mEtpTipo
End Property

Private Sub cmdCadastrar_Click()
    
    If Trim(Me.txtDescricao.Text) = "" Then
        MsgBox "É necessário uma descrição", vbInformation
        txtDescricao.SetFocus
        Exit Sub
    End If
    
    Call NovoTipo
    Me.txtDescricao = ""
End Sub

Private Sub cmdEditar_Click()
    
    Dim strDescricao As String
    
    Dim strNovaDescricao As String
        
    With lstTipos
        
        If .ListIndex = -1 Then
            MsgBox "Nenhum item selecionado para edição", vbExclamation
            Exit Sub
        End If
        
        strDescricao = .List(.ListIndex)
                
        strNovaDescricao = InputBox("Entre com a nova descrição para o tipo", , strDescricao)
                
    End With
    
    If Trim(strNovaDescricao) = "" Or Trim(strNovaDescricao) = Trim(strDescricao) Then Exit Sub
    
    Call AlterarTipo(strNovaDescricao)
    
End Sub

Private Sub cmdExcluir_Click()

    Dim strMsg As String
    Dim lngCodigoTipo As Long
    
    If lstTipos.ListIndex = -1 Then
        MsgBox "Você deve selecionar um tipo para pode excluir"
        Exit Sub
    End If
    
    
        
    With lstTipos
        lngCodigoTipo = .ItemData(.ListIndex)
    End With
    
    Call ExcluirTipo(lngCodigoTipo)

End Sub

Private Sub cmdSair_Click()
    Unload Me
End Sub

Private Function Validar() As Boolean
    If Trim(txtDescricao.Text) = "" Then
        MsgBox "É Necessário Pelo nome para Cadastrar"
        txtDescricao.SetFocus
    Else
        Validar = True
    End If
End Function

Private Sub AlterarTipo(ByVal strNovaDescricao As String)

    Dim objTipo As New ITipo
    
    Dim lngCodigoTipo As Long
    
    With lstTipos
        lngCodigoTipo = .ItemData(.ListIndex)
    End With
    
    With objTipo
        .Codigo = lngCodigoTipo
        .descricao = strNovaDescricao
        .Nome = mdlUtilsTipo.obterNomeTipo(Me.Tipo)
    End With
    
    Call mdlUtilsTipo.AlterarTipo(objTipo)
    
    AtualizaLista

End Sub

Private Sub ExcluirTipo(ByVal lngCodigoTipo As Long)

    Dim objTipo As New ITipo
    Dim strDescricao As String
    
    With lstTipos
        strDescricao = .List(.ListIndex)
    End With
    
    With objTipo
        .Codigo = lngCodigoTipo
        .descricao = strDescricao
        .Nome = mdlUtilsTipo.obterNomeTipo(Tipo)
    End With
    
    Call mdlUtilsTipo.ExcluirTipo(objTipo)
    
    AtualizaLista
    
End Sub

Private Sub NovoTipo()
    Dim objTipo As New ITipo
    
    With objTipo
        .descricao = txtDescricao
        .Nome = mdlUtilsTipo.obterNomeTipo(Tipo)
    End With
    
    Call mdlUtilsTipo.gravarTipo(objTipo)
    
    AtualizaLista
    
End Sub

Private Sub AtualizaLista()
    Dim rs As New ADODB.Recordset
    Dim strSQL As String
    Dim i As Integer
    Dim strNome As String
    
    strNome = mdlUtilsTipo.obterNomeTipo(Tipo)
    
    strSQL = "  SELECT " & _
             "      codigo" & strNome & " AS codigo, " & _
             "      Descricao" & _
             "  FROM" & _
             "      " & strNome
    
    rs.Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
    
    lstTipos.Clear
    
    While Not rs.EOF
        With lstTipos
            Call .AddItem(rs.Fields("descricao").Value)
            .ItemData(.NewIndex) = rs.Fields("codigo").Value
        End With
        rs.MoveNext
    Wend
End Sub

Private Sub Form_Load()
    
    Call mdlUtilsCtrls.configurarCorDeFundo(Me)
    
End Sub

Private Sub IToolBarControles_atualizar()
    AtualizaLista
End Sub

Private Sub IToolBarControles_limpar()
    Me.txtDescricao.Text = ""
End Sub
