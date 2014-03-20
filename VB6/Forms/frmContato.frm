VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form frmContato 
   Caption         =   "Contato"
   ClientHeight    =   5925
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   8280
   Icon            =   "frmContato.frx":0000
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
      Caption         =   "&Novo"
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
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      _Version        =   327682
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      Appearance      =   1
      NumItems        =   2
      BeginProperty ColumnHeader(1) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Nome"
         Object.Width           =   3528
      EndProperty
      BeginProperty ColumnHeader(2) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   1
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Sobrenome"
         Object.Width           =   5292
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
         NumTabs         =   1
         BeginProperty Tab1 {0713F341-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "&Todos"
            Object.Tag             =   ""
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmContato"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Implements IToolBarControles


Private Sub cmdAdicionar_Click()
    
    Dim objFrm As New frmCadastroContato
    
    objFrm.Show vbModal
    
    IToolBarControles_atualizar
    
End Sub

Private Sub cmdAlterar_Click()
       
    Dim objFrm As frmCadastroContato
       
    
    With ltwTarefa
        
        If .SelectedItem Is Nothing Then Exit Sub
        
        Set objFrm = New frmCadastroContato
        
        objFrm.codigoContato = CLng(Replace(.SelectedItem.Key, "c", ""))
        
        objFrm.Show vbModal
        
    End With
    
    IToolBarControles_atualizar

    
End Sub

Private Sub cmdExcluir_Click()


    With ltwTarefa
        
        If .SelectedItem Is Nothing Then Exit Sub
        
        Call mdlContato.excluirContato(CLng(Replace(.SelectedItem.Key, "c", "")))
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
    
    strCampos() = Split("codigoContato,Nome,Sobrenome", ",")
    
    'If Me.tabTarefas.SelectedItem.Index < 6 Then
    '
    '    strCriterio = " codigoStatus = " & (Me.tabTarefas.SelectedItem.Index - 1)
    '
    'End If
    
    strSQL = mdlAcessoDados.obterSQLSelect("Contato", strCampos, strCriterio)
    
    Set rs = mdlAcessoDados.obterRecordSet(strSQL)
    
    
    With ltwTarefa
        
        .ListItems.Clear
        
        .Sorted = False
        
        i = 1
        
        While Not rs.EOF
            
            .ListItems.Add i, CStr("c" & rs.Fields("codigoContato").Value), rs.Fields("Nome").Value
            .ListItems(i).SubItems(1) = rs.Fields("Sobrenome").Value
            i = i + 1
            rs.MoveNext
        Wend
    End With
    
    Me.ltwTarefa.Sorted = blnSorted
    
    Me.ltwTarefa.SortKey = intSortKey
    Me.ltwTarefa.SortOrder = intSortKey
End Sub

Private Sub IToolBarControles_atualizar()
    
    carregarTarefas
    
End Sub

Private Sub IToolBarControles_limpar()
    
    Me.ltwTarefa.ListItems.Clear
    
End Sub

Private Sub ltwTarefa_ColumnClick(ByVal ColumnHeader As ComctlLib.ColumnHeader)
    
    With ltwTarefa
        
        .SortOrder = IIf(.SortOrder = lvwAscending, lvwDescending, lvwAscending)
        
        .SortKey = ColumnHeader.Index - 1
    
        .Sorted = True
    
    End With
    
End Sub

Private Sub ltwTarefa_DblClick()
    cmdAlterar_Click
End Sub

Private Sub tabTarefas_Click()
    carregarTarefas
End Sub
