VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form frmCadastroTarefa 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Nova Tarefa"
   ClientHeight    =   3300
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8205
   Icon            =   "frmCadastroTarefa.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3300
   ScaleWidth      =   8205
   StartUpPosition =   1  'CenterOwner
   Begin VB.OptionButton optPrioridade 
      Caption         =   "&Baixa"
      Height          =   195
      Index           =   2
      Left            =   6420
      TabIndex        =   16
      Top             =   2130
      Width           =   1245
   End
   Begin VB.OptionButton optPrioridade 
      Caption         =   "&Normal"
      Height          =   195
      Index           =   1
      Left            =   6420
      TabIndex        =   15
      Top             =   1830
      Value           =   -1  'True
      Width           =   1245
   End
   Begin VB.OptionButton optPrioridade 
      Caption         =   "&Alta"
      Height          =   195
      Index           =   0
      Left            =   6420
      TabIndex        =   14
      Top             =   1530
      Width           =   1245
   End
   Begin VB.Frame fraPrioridade 
      Caption         =   "&Prioridade:"
      Height          =   1215
      Left            =   6300
      TabIndex        =   13
      Top             =   1230
      Width           =   1815
   End
   Begin VB.ComboBox txtTitulo 
      Height          =   315
      Left            =   60
      Style           =   1  'Simple Combo
      TabIndex        =   1
      Top             =   270
      Width           =   4095
   End
   Begin VB.CommandButton cmdAdicionar 
      Caption         =   "&Incluir"
      Enabled         =   0   'False
      Height          =   315
      Left            =   6630
      TabIndex        =   4
      Top             =   2550
      UseMaskColor    =   -1  'True
      Width           =   1245
   End
   Begin VB.CommandButton cmdSair 
      Caption         =   "&Sair"
      Height          =   315
      Left            =   6630
      TabIndex        =   17
      Top             =   2940
      Width           =   1245
   End
   Begin VB.TextBox txtDescricao 
      Height          =   2355
      Left            =   60
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   870
      Width           =   6165
   End
   Begin VB.ComboBox cboStatus 
      Height          =   315
      ItemData        =   "frmCadastroTarefa.frx":0442
      Left            =   4230
      List            =   "frmCadastroTarefa.frx":0455
      TabIndex        =   6
      Top             =   270
      Width           =   1965
   End
   Begin MSMask.MaskEdBox mskDataInicial 
      Height          =   315
      Left            =   6300
      TabIndex        =   8
      Top             =   270
      Width           =   1125
      _ExtentX        =   1984
      _ExtentY        =   556
      _Version        =   393216
      AutoTab         =   -1  'True
      MaxLength       =   10
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskHoraInicial 
      Height          =   315
      Left            =   7470
      TabIndex        =   9
      Top             =   270
      Width           =   615
      _ExtentX        =   1085
      _ExtentY        =   556
      _Version        =   393216
      AutoTab         =   -1  'True
      MaxLength       =   5
      Mask            =   "##:##"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskDataLimite 
      Height          =   315
      Left            =   6300
      TabIndex        =   11
      Top             =   870
      Width           =   1125
      _ExtentX        =   1984
      _ExtentY        =   556
      _Version        =   393216
      AutoTab         =   -1  'True
      MaxLength       =   10
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskHoraLimite 
      Height          =   315
      Left            =   7470
      TabIndex        =   12
      Top             =   870
      Width           =   615
      _ExtentX        =   1085
      _ExtentY        =   556
      _Version        =   393216
      AutoTab         =   -1  'True
      MaxLength       =   5
      Mask            =   "##:##"
      PromptChar      =   "_"
   End
   Begin VB.Label Label1 
      Caption         =   "&Título:"
      Height          =   225
      Left            =   90
      TabIndex        =   0
      Top             =   60
      Width           =   585
   End
   Begin VB.Label Label2 
      Caption         =   "&Status"
      Height          =   225
      Left            =   4260
      TabIndex        =   5
      Top             =   60
      Width           =   675
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "&Descrição:"
      Height          =   195
      Left            =   60
      TabIndex        =   2
      Top             =   630
      Width           =   765
   End
   Begin VB.Label Label5 
      Caption         =   "Data e hora &inicial"
      Height          =   225
      Left            =   6330
      TabIndex        =   7
      Top             =   30
      Width           =   1515
   End
   Begin VB.Label Label6 
      Caption         =   "Data e hora &final"
      Height          =   225
      Left            =   6330
      TabIndex        =   10
      Top             =   630
      Width           =   1515
   End
End
Attribute VB_Name = "frmCadastroTarefa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Sebastião Relson, quarta-feira, 23 de maio de 2007
'
' - Sugestão de Título.
Option Explicit

Implements IToolBarControles

Private mLngCodigoTarefa As Long
Private mUdtTarefa As TypeTarefa
Private mUdtTarefaEditada As TypeTarefa
Private mEmoModoOperacao As enumModoOperacao

Private blnCarregando As Boolean

Public Property Get modoOperacao() As enumModoOperacao
    
    If mLngCodigoTarefa = 0 Then
        modoOperacao = emoInsercao
        Exit Property
    Else
        modoOperacao = emoAlteracao
        Exit Property
    End If
    
End Property

Public Property Let codigoTarefa(ByVal lngCodigoTarefa As Long)
    
    mLngCodigoTarefa = lngCodigoTarefa
    
End Property

Public Property Get statusSelecionado() As STATUS_TAREFA
    
    With cboStatus
    
        statusSelecionado = .ItemData(.ListIndex)
    
    End With
    
End Property

Public Property Get prioridadeSelecionada() As PrioridadeTarefaConstantes
    
    Dim i As Integer
    
    For i = optPrioridade.LBound To optPrioridade.UBound
        If optPrioridade(i).Value Then
            prioridadeSelecionada = i
            Exit Property
        End If
    Next i
    
End Property

Private Sub cboStatus_Change()
    
    If Not blnCarregando Then cmdAdicionar.Enabled = existeAlteracoes
    
End Sub

Private Sub cboStatus_Click()
    cboStatus_Change
End Sub

Private Sub cboStatus_KeyPress(KeyAscii As Integer)
    
    Call mdlUtilsCtrls.tratarKeyPressComboBox(cboStatus, KeyAscii)
    
End Sub

Private Sub cmdAdicionar_Click()
    
    Dim frmLstTarefas As IToolBarControles
    
    With cboStatus
    
        If modoOperacao = emoInsercao Then
    
            If mdlTarefa.inserir(Me.txtTitulo.Text, Me.txtDescricao.Text, .ItemData(.ListIndex), prioridadeSelecionada(), mskDataInicial.Text, mskDataLimite.Text, mskHoraInicial.Text, mskHoraLimite.Text) Then
                Set frmLstTarefas = frmTarefa
                
                frmLstTarefas.atualizar
                
            End If
            Me.txtTitulo.SetFocus
        Else
        
            Call mdlTarefa.alterar(mUdtTarefa, mUdtTarefaEditada)
            Set frmLstTarefas = frmTarefa
                
            frmLstTarefas.atualizar
            Unload Me

        End If
        
    End With
       
    Call IToolBarControles_limpar
    
    
    
End Sub


Private Sub cmdSair_Click()
    
    Unload Me
    
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    
    If KeyCode = vbKeyEscape Then
        cmdSair_Click
    End If
    
End Sub

Private Sub Form_Load()
        
    Dim i As Integer
        
    Call mdlUtilsCtrls.configurarCorDeFundo(Me)
        
    blnCarregando = True
        
    mskDataInicial.Text = Format$(FormatDateTime(Now(), vbShortDate), "dd/MM/yyyy")
    mskHoraInicial.Text = Format$(Time$(), "hh:mm")
    mskHoraLimite.Text = Format$(Time$(), "hh:mm")
    mskDataLimite.Text = Format$(FormatDateTime(Now() + 1, vbShortDate), "dd/MM/yyyy")
    
    
    With cboStatus
        For i = 0 To 4
                
          .ItemData(i) = i
                
        Next
        
        .ListIndex = 0
        
    End With
    
    Call carregaSugestoesTitulo
    
    If modoOperacao = emoAlteracao Then
        
        mUdtTarefa = mdlTarefa.obterUdtTarefa(mLngCodigoTarefa)
        
        Me.Caption = "Alterar Tarefa"
        Me.cmdAdicionar.Caption = "&Alterar"
        Me.cmdSair.Caption = "&Cancelar"
        Me.cmdAdicionar.Enabled = False
        
        Me.txtTitulo.Text = mUdtTarefa.titulo
        Me.txtDescricao.Text = mUdtTarefa.Descricao
        
        Me.cboStatus.ListIndex = mUdtTarefa.status
        
        Me.mskDataInicial = Format$(mUdtTarefa.inicio, "dd/MM/yyyy")
        Me.mskDataLimite = Format$(mUdtTarefa.limite, "dd/MM/yyyy")
                
        Me.mskHoraInicial = Format$(mUdtTarefa.inicio, "hh:mm")
        Me.mskHoraLimite = Format$(mUdtTarefa.limite, "hh:mm")
        
        Me.optPrioridade(mUdtTarefa.prioridade).Value = True
        
    End If
    
    blnCarregando = False
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    
    mLngCodigoTarefa = 0
    
End Sub

Private Sub IToolBarControles_atualizar()

End Sub

Private Sub IToolBarControles_limpar()
   limparControles
End Sub

Private Sub mskDataInicial_Change()
    
If Not blnCarregando Then cmdAdicionar.Enabled = existeAlteracoes
    
End Sub

Private Sub mskDataLimite_Change()
    
    If Not blnCarregando Then cmdAdicionar.Enabled = existeAlteracoes
    
End Sub

Private Sub mskHoraInicial_LostFocus()
    mskDataLimite.Text = Format$(DateAdd("d", 1, mskDataInicial.Text), "dd/MM/yyyy")
    mskHoraLimite.Text = mskHoraInicial.Text
    mskHoraLimite.SetFocus
    
    If Not blnCarregando Then cmdAdicionar.Enabled = existeAlteracoes
    
End Sub

Private Function existeAlteracoes() As Boolean

    If Not tarefaValida() Then Exit Function
    
    mUdtTarefaEditada = obterUdtTarefaEditada()
    
    With mUdtTarefaEditada
    
        existeAlteracoes = (.titulo <> mUdtTarefa.titulo) Or _
                           (.Descricao <> mUdtTarefa.Descricao) Or _
                           (DateDiff("n", .inicio, mUdtTarefa.inicio) <> 0) Or _
                           (DateDiff("n", .limite, mUdtTarefa.limite) <> 0) Or _
                           (.status <> mUdtTarefa.status) Or _
                           (.prioridade <> mUdtTarefa.prioridade)
    End With
        
End Function


Private Function obterUdtTarefaEditada() As TypeTarefa
    
    Dim udtTarefa As TypeTarefa
    
    With udtTarefa
        .codigoTarefa = mUdtTarefa.codigoTarefa
        .titulo = Me.txtTitulo.Text
        .Descricao = Me.txtDescricao.Text
        .inicio = CDate(mskDataInicial.Text & " " & mskHoraInicial.Text)
        .limite = CDate(mskDataLimite.Text & " " & mskHoraLimite.Text)
        .status = Me.statusSelecionado()
        .prioridade = Me.prioridadeSelecionada()
    End With
    
    obterUdtTarefaEditada = udtTarefa
    
End Function

Private Sub mskHoraLimite_Change()
    
    If Not blnCarregando Then cmdAdicionar.Enabled = existeAlteracoes
    
End Sub

Private Sub optPrioridade_Click(Index As Integer)
    
    If Not blnCarregando Then cmdAdicionar.Enabled = existeAlteracoes
    
End Sub

Private Sub txtDescricao_Change()
    
    If Not blnCarregando Then cmdAdicionar.Enabled = existeAlteracoes
    
End Sub

Private Sub txtTitulo_Change()
    
    If Not blnCarregando Then cmdAdicionar.Enabled = existeAlteracoes
    
End Sub

Public Function tarefaValida() As Boolean
    
    tarefaValida = (Trim$(txtTitulo.Text) <> vbNullString) And _
                   (Trim$(txtDescricao.Text) <> vbNullString) And _
                   (IsDate(mskDataInicial.Text)) And _
                   (IsDate(mskHoraInicial.Text)) And _
                   (IsDate(mskDataLimite.Text)) And _
                   (IsDate(mskHoraLimite.Text))
                    
End Function

Public Sub limparControles()
    
    Me.txtTitulo = vbNullString
    Me.txtDescricao.Text = vbNullString
   
End Sub

Public Sub carregaSugestoesTitulo()
    
    Dim strSQL As String
    Dim rs As ADODB.Recordset
    
    Dim strTabela As String
    Dim strCampos(0) As String
    Dim strCriterio As String
    
    strTabela = "Tarefa"
    strCampos(0) = "DISTINCT titulo"
    strCriterio = " codigoStatus < 5"
    
    strSQL = mdlAcessoDados.obterSQLSelect(strTabela, strCampos, strCriterio)
    
    Set rs = mdlAcessoDados.obterRecordSet(strSQL)
    
    With txtTitulo
        While Not rs.EOF
            .AddItem Trim$(rs.Fields("titulo").Value)
            rs.MoveNext
        Wend
    End With
End Sub

Private Sub txtTitulo_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = vbKeyReturn Then
        With txtTitulo
            .SelStart = Len(txtTitulo.Text)
        End With
    End If
    
    Call mdlUtilsCtrls.tratarKeyPressComboBox(txtTitulo, KeyAscii)
    txtTitulo_Change
End Sub
