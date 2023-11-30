VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form frmDuvida 
   Caption         =   "Dúvidas"
   ClientHeight    =   5925
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   8280
   Icon            =   "frmDuvida.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   5925
   ScaleWidth      =   8280
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cmdSair 
      Caption         =   "&Sair"
      Height          =   315
      Left            =   6930
      TabIndex        =   5
      Top             =   5490
      Width           =   1245
   End
   Begin VB.CommandButton cmdAdicionar 
      Caption         =   "&Nova"
      Height          =   315
      Left            =   6900
      TabIndex        =   4
      Top             =   510
      UseMaskColor    =   -1  'True
      Width           =   1245
   End
   Begin VB.CommandButton cmdAlterar 
      Caption         =   "&Editar"
      Height          =   315
      Left            =   6900
      TabIndex        =   3
      Top             =   870
      UseMaskColor    =   -1  'True
      Width           =   1245
   End
   Begin VB.CommandButton cmdExcluir 
      Caption         =   "E&xcluir"
      Height          =   315
      Left            =   6900
      TabIndex        =   2
      Top             =   1230
      UseMaskColor    =   -1  'True
      Width           =   1245
   End
   Begin ComctlLib.ListView ltwTarefa 
      Height          =   4695
      Left            =   150
      TabIndex        =   0
      Top             =   510
      Width           =   6675
      _ExtentX        =   11774
      _ExtentY        =   8281
      View            =   3
      LabelEdit       =   1
      MultiSelect     =   -1  'True
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      _Version        =   327682
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      Appearance      =   1
      NumItems        =   5
      BeginProperty ColumnHeader(1) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Prioridade"
         Object.Width           =   1323
      EndProperty
      BeginProperty ColumnHeader(2) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   1
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Título"
         Object.Width           =   3528
      EndProperty
      BeginProperty ColumnHeader(3) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   2
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Descrição"
         Object.Width           =   9702
      EndProperty
      BeginProperty ColumnHeader(4) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   3
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Status"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(5) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   4
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Código"
         Object.Width           =   1764
      EndProperty
   End
   Begin ComctlLib.TabStrip tabTarefas 
      Height          =   5805
      Left            =   60
      TabIndex        =   1
      Top             =   90
      Width           =   8205
      _ExtentX        =   14473
      _ExtentY        =   10239
      _Version        =   327682
      BeginProperty Tabs {0713E432-850A-101B-AFC0-4210102A8DA7} 
         NumTabs         =   6
         BeginProperty Tab1 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "&Não Iniciadas"
            Key             =   ""
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Em &Andamento"
            Key             =   ""
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "&Pendente"
            Key             =   ""
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Concluída"
            Key             =   ""
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab5 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Cancelada"
            Key             =   ""
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab6 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "&Todas"
            Key             =   ""
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmDuvida"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Implements IToolBarControles

Private blnTratadoErro As Boolean

Private Sub cmdAdicionar_Click()
    
    frmCadastroTarefa.Show vbModal
    
End Sub

Private Sub cmdAlterar_Click()
    
    Dim lngCodigoTarefa As Long
    
    With ltwTarefa
        
        If .SelectedItem Is Nothing Then Exit Sub
        
        lngCodigoTarefa = CLng(Replace(.SelectedItem.Key, "c", ""))
        
        If Not lngCodigoTarefa > 0 Then Exit Sub
        
        frmCadastroTarefa.codigoTarefa = lngCodigoTarefa
        
        frmCadastroTarefa.Show vbModal
        
    End With
    
    IToolBarControles_atualizar

    
End Sub

Private Sub cmdExcluir_Click()


    With ltwTarefa
        
        If .SelectedItem Is Nothing Then Exit Sub
        
        Call mdlTarefa.Excluir(CLng(Replace(.SelectedItem.Key, "c", "")))
    End With
    
    IToolBarControles_atualizar
    
End Sub

Private Sub cmdSair_Click()
    
    Unload Me
    
End Sub

Private Sub Form_Load()
        
    Call mdlUtilsCtrls.configurarCorDeFundo(Me)
        
    Call carregarTarefas
    
End Sub

Private Sub Form_Resize()
    
    Dim intHeight As Integer
    Dim intWidth As Integer
    
    Dim intSpaceHeight As Integer
    Dim intSpaceWidth As Integer
    
    
    With Me.tabTarefas
        
        intWidth = ScaleWidth - .Left
        
        If intWidth > 0 Then
            .Width = intWidth
            
            intWidth = .ClientWidth - (.ClientLeft * 2) - Me.cmdAdicionar.Width
            If intWidth > 0 Then ltwTarefa.Width = intWidth
            
            Me.cmdAdicionar.Left = .ClientWidth - Me.cmdAdicionar.Width
            Me.cmdAlterar.Left = Me.cmdAdicionar.Left
            Me.cmdExcluir.Left = Me.cmdAdicionar.Left
            Me.cmdSair.Left = (.ClientLeft + .ClientWidth) - Me.cmdSair.Width + (.Top / 2)
            
            
        End If
        
        intHeight = ScaleHeight - (Me.cmdSair.Height + (.Top * 2))
        
        If intHeight > 0 Then
            .Height = intHeight
            
            intHeight = .ClientHeight - .ClientTop
            
            If intHeight > 0 Then ltwTarefa.Height = intHeight
            
            intHeight = ScaleHeight - (Me.cmdSair.Height + (.Top * 2))
            
            Me.cmdSair.Top = intHeight + .Top * 2
            
        End If
        
    End With
End Sub

Public Sub carregarTarefas()

    On Error GoTo Trata_Erro
    
    Dim rs As ADODB.Recordset
    Dim strSQL As String
    
    Dim strCampos() As String
    Dim strCriterio As String
    
    Dim blnSorted As Boolean
    Dim intSortKey As Integer
    Dim intSortOrder As Integer
    
    Dim i As Integer
    
    blnSorted = Me.ltwTarefa.Sorted
    
    intSortKey = Me.ltwTarefa.SortKey
    intSortOrder = Me.ltwTarefa.SortOrder
    
    strCampos() = Split("codigoTarefa,Titulo,Descricao,codigoPrioridade,codigoStatus", ",")
    
    If Me.tabTarefas.SelectedItem.Index < 6 Then
        
        strCriterio = " codigoStatus = " & (Me.tabTarefas.SelectedItem.Index - 1) & " ORDER BY codigoPrioridade "
    Else
        strCriterio = " codigoStatus < 5 ORDER BY codigoPrioridade"
    End If
    
    strSQL = mdlAcessoDados.obterSQLSelect(mdlTarefa.NOME_TABELA, strCampos, strCriterio)
    
    Set rs = mdlAcessoDados.obterRecordSet(strSQL)
    
    
    With ltwTarefa
        
        .ListItems.Clear
        
        .Sorted = False
        
        i = 1
        
        While Not rs.EOF
            
            .ListItems.Add i, CStr("c" & rs.Fields("codigoTarefa").Value), mdlTarefa.obterNomePrioridade(rs.Fields("codigoPrioridade").Value)
            ' Adiciona o a descrição subtituindo as quebras de linha por "/"
            .ListItems(i).SubItems(1) = rs.Fields("Titulo").Value
            .ListItems(i).SubItems(2) = Replace(rs.Fields("Descricao").Value, vbCrLf, "/")
            .ListItems(i).SubItems(3) = obterNomeStatusTarefa(rs.Fields("codigoStatus").Value)
            .ListItems(i).SubItems(4) = Format$(rs.Fields("codigoTarefa").Value, "0000")
            i = i + 1
            rs.MoveNext
        Wend
    End With
    
    Me.ltwTarefa.Sorted = blnSorted
    
    Me.ltwTarefa.SortKey = intSortKey
    Me.ltwTarefa.SortOrder = intSortKey
    
    Exit Sub
Trata_Erro:
        
    If Not blnTratadoErro Then
        Call criarColunaCodigoStatus
        blnTratadoErro = True
        carregarTarefas
    Else
        Call MsgBox("Não foi possível carregar a lista de tarefas." & vbCrLf & _
            "Erro Nº" & vbTab & ": " & Err.Number & vbCrLf & _
            "Descrição" & vbTab & ": " & Err.Description, vbCritical, "Erro")
    End If
End Sub

Private Sub IToolBarControles_atualizar()
    
    carregarTarefas
    
End Sub

Private Sub IToolBarControles_limpar()
    
    Me.ltwTarefa.ListItems.Clear
    
End Sub

Private Sub ltwTarefa_DblClick()
    cmdAlterar_Click
End Sub

Private Sub tabTarefas_Click()
    carregarTarefas
End Sub

Private Sub ltwTarefa_ColumnClick(ByVal ColumnHeader As ComctlLib.ColumnHeader)
    
    With ltwTarefa
        
        .SortOrder = IIf(.SortOrder = lvwAscending, lvwDescending, lvwAscending)
        
        .SortKey = ColumnHeader.Index - 1
    
        .Sorted = True
    
    End With
    
End Sub

Public Function obterNomeStatusTarefa(ByVal eCodigoStatus As STATUS_TAREFA) As String
    
    Dim strNome As String
    
    Select Case eCodigoStatus
        Case STATUS_TAREFA.CANCELADA
            strNome = "Cancelada"
        Case STATUS_TAREFA.CONCLUIDO
            strNome = "Concluída"
        Case STATUS_TAREFA.EM_ANDAMENTO
            strNome = "Em Andamento"
        Case STATUS_TAREFA.NAO_INICIADO
            strNome = "Não Iniciada"
        Case STATUS_TAREFA.PENDENTE
            strNome = "Pendente"
    End Select
    
    obterNomeStatusTarefa = strNome
    
End Function

Private Sub criarColunaCodigoStatus()
    
    Dim cn As ADODB.Connection
    
    Set cn = mdlAcessoDados.obterConexao()
    
    Dim strSQL As String
    
    strSQL = "ALTER TABLE Tarefa ADD COLUMN codigoPrioridade INTEGER NOT NULL DEFAULT 1"
    
    Call cn.Execute(strSQL)
    
    
    strSQL = "UPDATE Tarefa SET codigoPrioridade = 1"
    
    Call cn.Execute(strSQL)
    
End Sub
