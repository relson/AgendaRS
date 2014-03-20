VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form frmCadastroContato 
   Caption         =   "Cadastro - Contato"
   ClientHeight    =   5595
   ClientLeft      =   60
   ClientTop       =   270
   ClientWidth     =   8190
   Icon            =   "frmCadastroContato.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5595
   ScaleWidth      =   8190
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdExcluir 
      Caption         =   "E&xcluir"
      Height          =   315
      Left            =   5370
      TabIndex        =   15
      Top             =   2580
      UseMaskColor    =   -1  'True
      Width           =   1245
   End
   Begin VB.CommandButton cmdAlterar 
      Caption         =   "&Editar"
      Height          =   315
      Left            =   5370
      TabIndex        =   14
      Top             =   2220
      UseMaskColor    =   -1  'True
      Width           =   1245
   End
   Begin MSMask.MaskEdBox mskTelefone 
      Height          =   285
      Left            =   360
      TabIndex        =   11
      Top             =   1800
      Visible         =   0   'False
      Width           =   2625
      _ExtentX        =   4630
      _ExtentY        =   503
      _Version        =   393216
      AutoTab         =   -1  'True
      MaxLength       =   14
      Mask            =   "(##) ####-####"
      PromptChar      =   "_"
   End
   Begin VB.ListBox lstLista 
      Height          =   1815
      Left            =   300
      TabIndex        =   10
      Top             =   2220
      Width           =   5055
   End
   Begin VB.TextBox txtEndLabel 
      BackColor       =   &H80000004&
      BorderStyle     =   0  'None
      Height          =   195
      Left            =   390
      Locked          =   -1  'True
      TabIndex        =   9
      TabStop         =   0   'False
      Text            =   "Endereço"
      Top             =   1560
      Width           =   345
   End
   Begin VB.TextBox Text1 
      BackColor       =   &H80000004&
      BorderStyle     =   0  'None
      Height          =   195
      Left            =   3060
      Locked          =   -1  'True
      TabIndex        =   8
      TabStop         =   0   'False
      Text            =   "Tipo"
      Top             =   1560
      Width           =   375
   End
   Begin VB.TextBox txtEnd 
      Height          =   285
      Left            =   360
      TabIndex        =   6
      Top             =   1800
      Width           =   2625
   End
   Begin VB.ListBox lstTipoContato 
      Height          =   1635
      Left            =   300
      Style           =   1  'Checkbox
      TabIndex        =   7
      Top             =   2220
      Visible         =   0   'False
      Width           =   5055
   End
   Begin VB.ComboBox cboTipo 
      Height          =   315
      Left            =   3090
      TabIndex        =   12
      Top             =   1770
      Width           =   2205
   End
   Begin VB.CommandButton cmdAdicionar 
      Caption         =   "&Incluir"
      Height          =   315
      Left            =   5370
      TabIndex        =   13
      Top             =   1770
      UseMaskColor    =   -1  'True
      Width           =   1245
   End
   Begin VB.TextBox txtSobreNome 
      Height          =   285
      Left            =   3690
      MaxLength       =   80
      TabIndex        =   3
      Top             =   360
      Width           =   2985
   End
   Begin VB.CommandButton cmdCadastrar 
      Caption         =   "&Novo"
      Enabled         =   0   'False
      Height          =   315
      Left            =   5460
      TabIndex        =   4
      Top             =   720
      Width           =   1245
   End
   Begin VB.TextBox txtNome 
      Height          =   285
      Left            =   60
      MaxLength       =   80
      TabIndex        =   1
      Top             =   360
      Width           =   3555
   End
   Begin VB.CommandButton cmdSair 
      Caption         =   "&Sair"
      Height          =   315
      Left            =   5430
      TabIndex        =   16
      Top             =   4530
      Width           =   1245
   End
   Begin ComctlLib.TabStrip tabComplementos 
      Height          =   3315
      Left            =   90
      TabIndex        =   5
      Top             =   1140
      Width           =   6615
      _ExtentX        =   11668
      _ExtentY        =   5847
      _Version        =   327682
      BeginProperty Tabs {0713E432-850A-101B-AFC0-4210102A8DA7} 
         NumTabs         =   4
         BeginProperty Tab1 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "&E-mails"
            Key             =   "email"
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Telefones"
            Key             =   "telefone"
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "En&dereços"
            Key             =   "endereco"
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Tipo do &Contato"
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin VB.Label Labels 
      AutoSize        =   -1  'True
      Caption         =   "&Nome:"
      Height          =   195
      Index           =   1
      Left            =   90
      TabIndex        =   0
      Top             =   120
      Width           =   465
   End
   Begin VB.Label Labels 
      AutoSize        =   -1  'True
      Caption         =   "So&brenome:"
      Height          =   195
      Index           =   2
      Left            =   3690
      TabIndex        =   2
      Top             =   120
      Width           =   855
   End
End
Attribute VB_Name = "frmCadastroContato"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Implements IToolBarControles

Private blnConfigurando As Boolean

Private mLngCodigoContato As Long
Private mStrNomeContato As String
Private mStrSobrenomeContato As String

Private mEmoModoOperacao As enumModoOperacao

' Controle para  as entidades vinculadas ao Contato
Private mEmoModoOperacaoEntidade As enumModoOperacao

Private mLngCodigoEntidade As Long
Private mStrDescricaoEntidade As String
Private mLngCodigoTipoEntidade As Long

Public Property Get modoOperacaoEntidade() As enumModoOperacao
    
    If mLngCodigoEntidade = 0 Then
        modoOperacaoEntidade = emoInsercao
        Exit Property
    Else
        modoOperacaoEntidade = emoAlteracao
        Exit Property
    End If
    
End Property

Public Property Let codigoEntidade(ByVal lngCodigoEntidade As Long)
    
    mLngCodigoEntidade = lngCodigoEntidade
        
End Property

Public Property Get codigoEntidade() As Long
    
    codigoEntidade = mLngCodigoEntidade
    
End Property

Public Property Get modoOperacao() As enumModoOperacao
    
    If mLngCodigoContato = 0 Then
        modoOperacao = emoInsercao
        Exit Property
    Else
        modoOperacao = emoAlteracao
        Exit Property
    End If
    
End Property

Public Property Get codigoContato() As Long
    codigoContato = mLngCodigoContato
End Property

Public Property Let codigoContato(ByVal lngCodigoContato As Long)
    
    mLngCodigoContato = lngCodigoContato
    
    Me.cmdCadastrar.Caption = "&Alterar"
    
    txtCodigo_LostFocus
    
    Me.Caption = "Alterar - Contato(" & Me.nomeContato & ")"
    
End Property

Public Property Get nomeContato() As String
    nomeContato = mStrNomeContato
End Property

Public Property Get sobrenomeContato() As String
    sobrenomeContato = mStrSobrenomeContato
End Property

Private Sub cboTipo_KeyPress(KeyAscii As Integer)
    
    Call mdlUtilsCtrls.tratarKeyPressComboBox(cboTipo, KeyAscii)
    
End Sub



Private Sub cmdAdicionar_Click()
    
    Dim i As Integer
    
    If cboTipo.ListIndex = -1 Then
        MsgBox "Selecione um tipo", vbExclamation
        cboTipo.SetFocus
        Exit Sub
    End If
    
    i = tabComplementos.SelectedItem.Index
    
    If modoOperacaoEntidade = emoInsercao Then
        
        Select Case i
            Case 1
                adicionarEmail
            Case 2
                adicionarTelefone
            Case 3
                adicionarEndereco
        End Select
                
    ElseIf modoOperacaoEntidade = emoAlteracao Then
            
        Me.cmdAlterar.Enabled = True
        Me.cmdAdicionar.Caption = "&Incluir"
        
        Dim strEntidade As String
        Dim strCampos(1) As String
        Dim strValores(1) As String
        
        strEntidade = mdlContato.obterNomeEntidade(i)
        
        strCampos(0) = obterNomeDescricaoEntidade(i)
        strCampos(1) = "codigoTipo" & strEntidade
        
        strValores(0) = mdlUtils.aspas(IIf(i = 2, Me.mskTelefone.Text, Me.txtEnd.Text))
        
        With cboTipo
            strValores(1) = .ItemData(.ListIndex)
        End With
        
        Call mdlAcessoDados.executarUpdate(strEntidade, strCampos, strValores, " codigo" & strEntidade & " = " & mLngCodigoEntidade)
        
    End If
    limpaMsk
    Me.txtEnd.Text = vbNullString
    ' Recarrega a Lista
    tabComplementos_Click
    
End Sub

Private Sub cmdAlterar_Click()

    If lstLista.ListIndex = -1 Then
        MsgBox "Nada selecionado para edição", vbInformation
        Exit Sub
    End If
    
    Me.codigoEntidade = obterCodigoEntidade
    
    Me.cmdAdicionar.Caption = "&Alterar"
    
End Sub

Private Sub cmdCadastrar_Click()
    
    Dim objFrm As IToolBarControles
    
    If modoOperacao = emoInsercao Then
        Call NovoContato
        Set objFrm = frmContato
        objFrm.atualizar
    ElseIf modoOperacao = emoAlteracao Then
        Call AlterarContato
        txtCodigo_LostFocus
    End If
End Sub

Private Sub cmdExcluir_Click()
    
    If lstLista.ListIndex = -1 Then
        MsgBox "Nada selecionado para exclusão", vbInformation
        Exit Sub
    End If
    
    Call mdlContato.Excluir(Me.codigoContato, tabComplementos.SelectedItem.Index, lstLista)
    
    IToolBarControles_atualizar
        
End Sub

Private Sub cmdExcluirContato_Click()
    
    On Error GoTo TrataErro
    
    Call mdlContato.excluirContato(Me.codigoContato)
        
    IToolBarControles_limpar
    
    Exit Sub
TrataErro:
    mdiMain.cn.RollbackTrans
    MsgBox "Erro ao tentar excluir o contato", vbCritical
End Sub

Private Sub cmdPesquisar_Click()
    
    Dim objFrm As New frmPesquisa
    
    frmPesquisa.Show 1
        
    txtCodigo_LostFocus
        
End Sub

Private Sub cmdSair_Click()
    Unload Me
End Sub

Private Function Validar() As Boolean
    If Trim(txtNome.Text) = "" Then
        MsgBox "É Necessário um nome Cadastrar", vbInformation
        txtNome.SetFocus
    Else
        Validar = True
    End If
End Function

Private Sub NovoContato()
    If Not Validar() Then Exit Sub
    
    Dim rs As ADODB.Recordset
    Dim strSQL As String
    Dim strCodigo As String
    Dim i As Integer
    
    strSQL = "INSERT INTO Contato(nome, sobrenome) VALUES('" & _
             txtNome.Text & "','" & txtSobreNome.Text & "')"
    
    Call mdiMain.cn.Execute(strSQL, i)
    
    strSQL = "SELECT max(codigoContato) as codigoContato FROM Contato"
        
    Set rs = mdiMain.cn.Execute(strSQL)
    
    strCodigo = Format$(rs.Fields("codigoContato").Value, "0000")
    
    'MsgBox "Novo Contato" & vbCrLf & "Codigo:" & strCodigo
    
    Me.codigoContato = strCodigo
End Sub

Private Sub AlterarContato()
    
    Dim strCampos(1) As String
    Dim strValores(1) As String
    
    strCampos(0) = "nome": strValores(0) = aspas(Me.txtNome.Text)
    strCampos(1) = "sobrenome": strValores(1) = aspas(Me.txtSobreNome.Text)
    
    Call mdlAcessoDados.executarUpdate("Contato", strCampos, strValores, "codigoContato = " & codigoContato)
        
    txtCodigo_LostFocus
    
End Sub


Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
        
    If KeyCode = vbKeyEscape Then
        cmdSair_Click
    End If
    
End Sub

Private Sub Form_Load()

    Call mdlUtilsCtrls.configurarCorDeFundo(Me)
    configuraListasTipo
    configuraTexts
    txtCodigo_LostFocus
End Sub

Private Sub Form_Resize()
    
    If Width <= 7230 Then
        DoEvents
        Width = 7230
        Exit Sub
    End If
    
    With cmdSair
        .Left = (Me.Width - (.Width + 210))
        .Top = (Me.Height - (.Height + 600))
    End With
    
    With cmdCadastrar
        .Left = (Me.Width - (.Width + 210))
        txtSobreNome.Width = .Left - txtSobreNome.Left + .Width
    End With
    
    With cmdAdicionar
        .Left = (Me.Width - (.Width + 460))
    End With
    
    With cmdExcluir
        .Left = (Me.Width - (.Width + 460))
    End With
    
    With cmdAlterar
        .Left = (Me.Width - (.Width + 460))
    End With
    
    With tabComplementos
        .Width = Me.Width - (.Left + 210)
        .Height = Abs(Me.Height - 2150)
        
        lstLista.Width = .ClientWidth - (cmdAdicionar.Width + 560)
        lstLista.Height = Abs(.ClientHeight - 900)
        
        lstTipoContato.Width = .ClientWidth - (cmdAdicionar.Width + 560)
        lstTipoContato.Height = Abs(.ClientHeight - 900)

    End With
End Sub

Private Sub IToolBarControles_atualizar()
    
    If codigoContato > 0 Then
        Select Case tabComplementos.SelectedItem.Index
            Case 1
                Call carregaListaEmails
            Case 2
                Call carregaListaTelefones
            Case 3
                Call carregaListaEnderecos
            Case 4
                Call configuraTipoContato
            Case Else
                lstLista.Clear
        End Select
    End If
End Sub

Private Sub IToolBarControles_limpar()
    
    codigoContato = 0
    
    txtNome.Text = ""
    txtSobreNome.Text = ""
    
    limpaMsk
    
    txtEnd.Text = ""
    cboTipo.Clear
    cboTipo.Text = ""
    
    lstLista.Clear
    
    configuraListasTipo
    
    lstTipoContato.Clear
    
End Sub


Private Sub lstLista_DblClick()
    cmdAlterar_Click
End Sub

Private Sub lstTipoContato_ItemCheck(Item As Integer)

    If blnConfigurando Then Exit Sub
    
    If Me.codigoContato <= 0 Then
        
        Exit Sub
    End If
    
    If lstTipoContato.Selected(Item) Then
        Call insereContatoTipos(codigoContato, lstTipoContato.ItemData(Item))
    Else
        Call removeContatoTipos(codigoContato, lstTipoContato.ItemData(Item))
    End If
End Sub

Private Sub removeContatoTipos(ByVal lngCodigoContato As Long, ByVal lngCodigoTipoContato As Long)
    Dim strSQL As String
    
    If blnConfigurando Then Exit Sub
    
    strSQL = "DELETE FROM ContatoTipos " & _
             "    WHERE           codigoContato = " & lngCodigoContato & _
             "    AND             codigoTipoContato = " & lngCodigoTipoContato
             
    Call mdiMain.cn.Execute(strSQL)
    
End Sub

Private Sub insereContatoTipos(ByVal lngCodigoContato As Long, ByVal lngCodigoTipoContato As Long)
    Dim strSQL As String
    
    strSQL = "INSERT INTO ContatoTipos " & _
             "    VALUES(" & lngCodigoContato & "," & lngCodigoTipoContato & ")"
             
    Call mdiMain.cn.Execute(strSQL)
End Sub

Private Sub mskTelefone_GotFocus()
    mskTelefone.SelStart = 5
End Sub

Private Sub tabComplementos_Click()

    limpaMsk
    Me.txtEnd.Text = vbNullString
    Me.cmdAdicionar.Caption = "&Incluir"
    mLngCodigoEntidade = 0

    configuraTexts
    Select Case tabComplementos.SelectedItem.Index
        Case 4
            VisivelControles
            lstTipoContato.Visible = True
            mdlUtilsCtrls.configurarListaTipo 0, lstTipoContato
            configuraTipoContato
        Case Else
            Call mdlUtilsCtrls.configurarListaTipo(tabComplementos.SelectedItem.Index, cboTipo)
            lstTipoContato.Visible = False
            VisivelControles True
    End Select
    
    IToolBarControles_atualizar
End Sub

Private Sub txtCodigo_LostFocus()
    Dim rs As ADODB.Recordset
    Dim strSQL As String
    Dim i As Integer
    Dim lngTipoContato As Long
    
    If Me.codigoContato = 0 Then Exit Sub
    
    Set rs = New ADODB.Recordset
    rs.CursorLocation = adUseClient
    
    strSQL = "SELECT nome, sobrenome FROM Contato WHERE codigoContato = " & Me.codigoContato
        
    rs.Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
    
    If rs.RecordCount = 0 Then
        MsgBox "Nenhum contato encontrado", vbInformation
        Me.codigoContato = 0
        Exit Sub
    End If
        
    blnConfigurando = True
        
    'me.codigoContato = Format$(me.codigoContato, "0000")
    
    txtNome.Text = rs.Fields("nome").Value
    txtSobreNome.Text = rs.Fields("sobrenome").Value
    
    mStrNomeContato = txtNome.Text
    mStrSobrenomeContato = txtSobreNome.Text
    Me.Caption = "Alterar - Contato(" & Me.nomeContato & ")"
    cmdCadastrar.Enabled = False
    
    blnConfigurando = False
    
    IToolBarControles_atualizar
End Sub

Private Sub configuraListasTipo()
    Call mdlUtilsCtrls.configurarListaTipo(1, Me.cboTipo)
End Sub

Private Sub VisivelControles(Optional ByVal blnVisivel As Boolean = False)
    
    txtEnd.Visible = blnVisivel
    txtEndLabel.Visible = blnVisivel
    
    Text1.Visible = blnVisivel
    
    cboTipo.Visible = blnVisivel
    
    cmdAdicionar.Visible = blnVisivel
    cmdAlterar.Visible = blnVisivel
    cmdExcluir.Visible = blnVisivel
    
    lstLista.Visible = blnVisivel
    
    If tabComplementos.SelectedItem.Index = 2 Then
        mskTelefone.Visible = True
    Else
        mskTelefone.Visible = False
    End If
    
End Sub

Private Sub configuraTexts()
    With txtEndLabel
        Select Case tabComplementos.SelectedItem.Index
            Case 1
                .Text = "e-mail (ex:usuario@dominio.com.br)"
            Case 2
                .Text = "Número"
            Case 3
                .Text = "Endereço Completo"
        End Select
    
        .Width = TextWidth(.Text)
    End With
End Sub

Private Sub editarEndereco()
    If lstLista.ListIndex = -1 Then
    End If
End Sub

Private Sub adicionarEmail()
    Dim rs As ADODB.Recordset
    Dim strSQL As String
    
    
    ' Verifica se já existe um e-mail com esse endereço
    
    strSQL = "SELECT codigoEmail FROM Email WHERE endereco = '" & txtEnd.Text & "'"
    
    Set rs = New ADODB.Recordset
    rs.CursorLocation = adUseClient
    rs.Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
    
    ' Se não existir cria um novo.
    If rs.EOF Then
        Call adicionarNovoEmail(rs)
    ElseIf emailExisteParaContato(CLng(rs.Fields("codigoEmail"))) Then
        MsgBox "Esse e-mail já está atribuido para o contato", vbExclamation
        Exit Sub
    End If
    
        
    If Not rs.EOF Then
        strSQL = "INSERT INTO ContatoEmails VALUES(" & Me.codigoContato & "," & rs.Fields("codigoEmail").Value & ")"
        
        Call mdiMain.cn.Execute(strSQL)
    End If
    
    txtEnd.Text = ""
    
    
    IToolBarControles_atualizar
    
End Sub

Private Sub adicionarNovoEmail(ByRef adoRS As ADODB.Recordset)
    Dim strSQL As String
    Dim i As Integer
    
    With cboTipo
        strSQL = "INSERT INTO Email(codigoTipoEmail, endereco) VALUES(" & .ItemData(.ListIndex) & _
        ",'" & txtEnd.Text & "')"
    End With
    
    mdiMain.cn.Execute strSQL, i
    
    With adoRS
    
        If i > 0 Then
            strSQL = "SELECT MAX(codigoEmail) AS codigoEmail FROM Email"
                
            If .State <> 0 Then .Close
            .CursorLocation = adUseClient
            .Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
        End If
    End With
End Sub

Private Function emailExisteParaContato(ByVal lngCodigoEmail As Long) As Boolean
    Dim strSQL As String
    Dim rs As ADODB.Recordset
    
    Dim lngCodigoContato As Long
    
    
    lngCodigoContato = Me.codigoContato
    
    strSQL = "SELECT codigoContato FROM ContatoEmails WHERE codigoContato = " & lngCodigoContato & " AND codigoEmail = " & lngCodigoEmail
    
    Set rs = New ADODB.Recordset
    rs.CursorLocation = adUseClient
    rs.Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
    
    emailExisteParaContato = (rs.RecordCount > 0)
End Function


Private Sub carregaListaEmails()
    Dim strSQL As String
    Dim rs As ADODB.Recordset
    Dim strItem As String
    
    strSQL = "  SELECT " & _
             "      Email.codigoEmail, " & _
             "      Email.endereco, " & _
             "       TipoEmail.descricao " & _
             "  FROM " & _
             "      Email, " & _
             "      TipoEmail, " & _
             "      ContatoEmails " & _
             "  WHERE " & _
             "      ContatoEmails.codigoEmail = Email.codigoEmail AND " & _
             "      TipoEmail.codigoTipoEmail = Email.codigoTipoEmail AND " & _
             "      ContatoEmails.codigoContato = " & Me.codigoContato
             
    Set rs = New ADODB.Recordset
    rs.CursorLocation = adUseClient
    rs.Source = strSQL
    rs.ActiveConnection = mdiMain.cn
    rs.CursorType = adOpenForwardOnly
    rs.LockType = adLockReadOnly
    
    rs.Open
    
    lstLista.Clear
    
    While Not rs.EOF
        With lstLista
            
            strItem = rs.Fields("endereco").Value & " (" & rs.Fields("Descricao").Value & ")"
        
            Call .AddItem(strItem)
            
            .ItemData(.NewIndex) = rs.Fields("codigoEmail").Value
            
        End With
        rs.MoveNext
    Wend

End Sub

Private Sub carregaListaTelefones()
    Dim strSQL As String
    Dim rs As ADODB.Recordset
    Dim strItem As String
    
    strSQL = "  SELECT " & _
             "      Telefone.codigoTelefone, " & _
             "      Telefone.numero, " & _
             "      TipoTelefone.descricao " & _
             "  FROM " & _
             "      Telefone, " & _
             "      TipoTelefone, " & _
             "      ContatoTelefones " & _
             "  WHERE " & _
             "      ContatoTelefones.codigoTelefone = Telefone.codigoTelefone AND " & _
             "      TipoTelefone.codigoTipoTelefone = Telefone.codigoTipoTelefone AND " & _
             "      ContatoTelefones.codigoContato = " & Me.codigoContato
             
    Set rs = New ADODB.Recordset
    rs.CursorLocation = adUseClient
    rs.Source = strSQL
    rs.ActiveConnection = mdiMain.cn
    rs.CursorType = adOpenForwardOnly
    rs.LockType = adLockReadOnly
    
    rs.Open
    
    lstLista.Clear
    
    While Not rs.EOF
        With lstLista
            
            strItem = rs.Fields("numero").Value & " (" & rs.Fields("descricao").Value & ")"
        
            Call .AddItem(strItem)
            
            .ItemData(.NewIndex) = rs.Fields("codigoTelefone").Value
        End With
        rs.MoveNext
    Wend
End Sub

Private Sub carregaListaEnderecos()
    Dim strSQL As String
    Dim rs As ADODB.Recordset
    Dim strItem As String
    
    strSQL = "  SELECT " & _
             "      Endereco.codigoEndereco, " & _
             "      Endereco.endereco, " & _
             "      TipoEndereco.descricao " & _
             "  FROM " & _
             "      Endereco, " & _
             "      TipoEndereco, " & _
             "      ContatoEnderecos " & _
             "  WHERE " & _
             "      ContatoEnderecos.codigoEndereco = Endereco.codigoEndereco AND " & _
             "      TipoEndereco.codigoTipoEndereco = Endereco.codigoTipoEndereco AND " & _
             "      ContatoEnderecos.codigoContato = " & Me.codigoContato
             
    Set rs = New ADODB.Recordset
    rs.CursorLocation = adUseClient
    rs.Source = strSQL
    rs.ActiveConnection = mdiMain.cn
    rs.CursorType = adOpenForwardOnly
    rs.LockType = adLockReadOnly
    
    rs.Open
    
    lstLista.Clear
    
    While Not rs.EOF
        With lstLista
            
            strItem = rs.Fields("endereco").Value & " (" & rs.Fields("descricao").Value & ")"
        
            Call .AddItem(strItem)
            
            .ItemData(.NewIndex) = rs.Fields("codigoEndereco").Value
            
        End With
        rs.MoveNext
    Wend
End Sub

Private Sub configuraTipoContato()

    Dim rs As New ADODB.Recordset
    Dim strSQL As String
    Dim i As Integer
    Dim lngTipoContato  As Long
    
    blnConfigurando = True

    ' Configura os Tipos do Contato
    
    strSQL = "SELECT codigoTipoContato FROM  ContatoTipos WHERE codigoContato = " & Me.codigoContato
    
    If rs.State <> 0 Then rs.Close
    rs.CursorLocation = adUseClient
    
    rs.Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
    
    With lstTipoContato
        For i = 0 To .ListCount - 1
            .Selected(i) = False
        Next
    End With
    
    While Not rs.EOF
        
        lngTipoContato = rs.Fields("codigoTipoContato").Value
        
        With lstTipoContato
            For i = 0 To .ListCount - 1
                If lngTipoContato = .ItemData(i) Then
                    .Selected(i) = True
                    Exit For
                End If
            Next
        End With
        rs.MoveNext
    Wend
    blnConfigurando = False
End Sub

Private Sub adicionarTelefone()
    Dim rs As ADODB.Recordset
    Dim strSQL As String
    
    strSQL = "SELECT codigoTelefone FROM Telefone WHERE numero = '" & mskTelefone.Text & "'"
    
    Set rs = New ADODB.Recordset
    rs.CursorLocation = adUseClient
    rs.Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
    
    If rs.EOF Then
        Call adicionarNovoTelefone(rs)
    End If
    
    If Not rs.EOF Then
        strSQL = "INSERT INTO ContatoTelefones VALUES(" & Me.codigoContato & "," & rs.Fields("codigoTelefone").Value & ")"
        
        Call mdiMain.cn.Execute(strSQL)
    End If
    
    limpaMsk
    
    IToolBarControles_atualizar

End Sub

Private Sub adicionarNovoTelefone(ByRef adoRS As ADODB.Recordset)
    Dim strSQL As String
    Dim i As Integer
    
    With cboTipo
        strSQL = "INSERT INTO Telefone(codigoTipoTelefone, numero) VALUES(" & .ItemData(.ListIndex) & _
        ",'" & mskTelefone.Text & "')"
    End With
    
    mdiMain.cn.Execute strSQL, i
    
    With adoRS
    
        If i > 0 Then
            strSQL = "SELECT MAX(codigoTelefone) AS codigoTelefone FROM Telefone"
                
            If .State <> 0 Then .Close
            .CursorLocation = adUseClient
            .Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
        End If
    End With
    
    limpaMsk
    
End Sub

Private Sub adicionarEndereco()
    Dim rs As ADODB.Recordset
    Dim strSQL As String
    
    strSQL = "SELECT codigoEndereco FROM Endereco WHERE endereco = '" & txtEnd.Text & "'"
    
    Set rs = New ADODB.Recordset
    rs.CursorLocation = adUseClient
    rs.Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
    
    If rs.EOF Then
        Call adicionarNovoEndereco(rs)
    End If
    
    If Not rs.EOF Then
        strSQL = "INSERT INTO ContatoEnderecos VALUES(" & CLng(Me.codigoContato) & "," & rs.Fields("codigoEndereco").Value & ")"
        
        Call mdiMain.cn.Execute(strSQL)
    End If
    
    txtEnd.Text = ""
    
    IToolBarControles_atualizar
End Sub

Private Sub adicionarNovoEndereco(ByRef adoRS As ADODB.Recordset)
    Dim strSQL As String
    Dim i As Integer
    
    With cboTipo
        strSQL = "INSERT INTO Endereco(codigoTipoEndereco, endereco) VALUES(" & .ItemData(.ListIndex) & _
        ",'" & txtEnd.Text & "')"
    End With
    
    mdiMain.cn.Execute strSQL, i
    
    With adoRS
    
        If i > 0 Then
            strSQL = "SELECT MAX(codigoEndereco) AS codigoEndereco FROM Endereco"
                
            If .State <> 0 Then .Close
            .CursorLocation = adUseClient
            .Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
        End If
    End With
End Sub

Private Sub limpaMsk()
    Dim strMsk As String
    
    With mskTelefone
        strMsk = .Mask
        
        .Mask = ""
        
        .Text = "(62) ____-____"
        
        .Mask = strMsk
        
    End With
End Sub

Private Sub editarEmail()

End Sub

Private Sub editarTelefone()

End Sub

Private Sub txtNome_Change()
    
    If Not blnConfigurando Then cmdCadastrar.Enabled = existeAlteracoes
    
End Sub

Private Sub txtSobreNome_Change()

    If Not blnConfigurando Then cmdCadastrar.Enabled = existeAlteracoes

End Sub


Private Function existeAlteracoes() As Boolean
    
    existeAlteracoes = contatoValido
    
    If modoOperacao = emoInsercao Then Exit Function
    
    existeAlteracoes = contatoValido And ((Trim$(txtNome.Text) <> nomeContato) Or _
                       (Trim$(txtSobreNome.Text) <> sobrenomeContato))
End Function

Private Function contatoValido() As Boolean
    contatoValido = Trim$(Me.txtNome.Text <> vbNullString)
End Function

Private Function obterCodigoEntidade() As Long

    Dim lngCodigoEntidade As Long
    
    With Me.lstLista
        lngCodigoEntidade = .ItemData(.ListIndex)
        
        mStrDescricaoEntidade = obterDescricaoEntidada(lngCodigoEntidade)
        
        If Me.tabComplementos.SelectedItem.Index = 2 Then
            Me.mskTelefone.Text = mStrDescricaoEntidade
        Else
            Me.txtEnd.Text = mStrDescricaoEntidade
        End If
        
        .RemoveItem .ListIndex
        Me.cmdAlterar.Enabled = False
    End With
    
    obterCodigoEntidade = lngCodigoEntidade
    
End Function

Private Function obterNomeDescricaoEntidade(ByVal intIndice As Integer)
    Select Case intIndice
            Case 1, 3
                obterNomeDescricaoEntidade = "endereco"
            Case 2
                obterNomeDescricaoEntidade = "numero"
        End Select
End Function

Private Function obterDescricaoEntidada(ByVal lngCodigoEntidade As Long)
        
    Dim strSQL As String
    Dim rs As New ADODB.Recordset
    
    Dim strNomeEntidade As String
    Dim strCampos(1) As String
    
    Dim lngCodigoTipoEntidade As Long
    
    Dim i As Integer
    
    i = tabComplementos.SelectedItem.Index
    
    strNomeEntidade = mdlContato.obterNomeEntidade(i)
    
    strCampos(0) = obterNomeDescricaoEntidade(i)
    strCampos(1) = "codigoTipo" & strNomeEntidade
    
    strSQL = mdlAcessoDados.obterSQLSelect(strNomeEntidade, strCampos, "codigo" & strNomeEntidade & " = " & lngCodigoEntidade)
    
    Set rs = mdlAcessoDados.obterRecordSet(strSQL)
    
    obterDescricaoEntidada = rs.Fields(obterNomeDescricaoEntidade(i))
    
    lngCodigoTipoEntidade = rs.Fields("codigoTipo" & strNomeEntidade)
    
    Call configurarTipoEntidade(lngCodigoTipoEntidade)
    
    mLngCodigoTipoEntidade = lngCodigoTipoEntidade
    
End Function

Private Sub configurarTipoEntidade(ByVal lngCodigoTipoEntidade As Long)
    
    Dim i As Integer
    
    With Me.cboTipo
        For i = 0 To .ListCount
            If .ItemData(i) = lngCodigoTipoEntidade Then
                .ListIndex = i
                Exit Sub
            End If
        Next i
    End With
End Sub
