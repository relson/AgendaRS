VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.MDIForm mdiMain 
   BackColor       =   &H8000000C&
   Caption         =   "AgendaRS"
   ClientHeight    =   6870
   ClientLeft      =   165
   ClientTop       =   555
   ClientWidth     =   11820
   Icon            =   "mdiMain.frx":0000
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   1  'CenterOwner
   WindowState     =   2  'Maximized
   Begin ComctlLib.Toolbar tbrMain 
      Align           =   1  'Align Top
      Height          =   870
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11820
      _ExtentX        =   20849
      _ExtentY        =   1535
      ButtonWidth     =   1535
      ButtonHeight    =   1376
      Appearance      =   1
      ImageList       =   "imgListToolBar"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   12
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Contato"
            Object.ToolTipText     =   "Contatos"
            Object.Tag             =   "contato"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Tarefa"
            Object.ToolTipText     =   "Tarefas"
            Object.Tag             =   "tarefa"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Anotações"
            Object.ToolTipText     =   "Anotações"
            Object.Tag             =   "anotacao"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Dúvidas"
            Object.ToolTipText     =   "Dúvidas"
            Object.Tag             =   "duvida"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button5 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Sugestões"
            Object.ToolTipText     =   "Sugestões"
            Object.Tag             =   "sugestao"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button6 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button7 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button8 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            Object.Width           =   1e-4
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button9 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Atualizar"
            Object.ToolTipText     =   "Atualizar o Formulário"
            Object.Tag             =   "atualizar"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button10 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Limpar"
            Object.ToolTipText     =   "Limpar Formulário"
            Object.Tag             =   "limpar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button11 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button12 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Sair"
            Key             =   "sair"
            Object.ToolTipText     =   "Encerrar AgendaRS"
            Object.Tag             =   "sair"
            ImageIndex      =   11
         EndProperty
      EndProperty
   End
   Begin ComctlLib.ImageList imgListToolBar 
      Left            =   5640
      Top             =   3150
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   11
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "mdiMain.frx":0442
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "mdiMain.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "mdiMain.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "mdiMain.frx":0D90
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "mdiMain.frx":10AA
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "mdiMain.frx":13C4
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "mdiMain.frx":16DE
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "mdiMain.frx":19F8
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "mdiMain.frx":1D12
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "mdiMain.frx":202C
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "mdiMain.frx":2346
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu mnuArquivo 
      Caption         =   "&Arquivo"
      Begin VB.Menu mnuAbrir 
         Caption         =   "&Abrir"
      End
      Begin VB.Menu mnuSeparador05 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSubCadastro 
         Caption         =   "&Contatos"
         Index           =   0
      End
      Begin VB.Menu mnuTarefas 
         Caption         =   "&Tarefas"
      End
      Begin VB.Menu mnuAnotacao 
         Caption         =   "A&notações"
      End
      Begin VB.Menu mnuDuvida 
         Caption         =   "&Dúvidas"
      End
      Begin VB.Menu mnuSugestao 
         Caption         =   "Su&gestões"
      End
      Begin VB.Menu mnuSepArquivo02 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSair 
         Caption         =   "&Sair"
      End
   End
   Begin VB.Menu mnuCadastro 
      Caption         =   "&Editar"
      Begin VB.Menu mnuTipo 
         Caption         =   "&Tipos"
         Begin VB.Menu mnuTipos 
            Caption         =   "&Contato"
            Index           =   0
         End
         Begin VB.Menu mnuTipos 
            Caption         =   "&e-mail"
            Index           =   1
         End
         Begin VB.Menu mnuTipos 
            Caption         =   "&Telefone"
            Index           =   2
         End
         Begin VB.Menu mnuTipos 
            Caption         =   "&Endereço"
            Index           =   3
         End
      End
      Begin VB.Menu mnuConfigurarSep 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPreferencias 
         Caption         =   "Preferências"
      End
   End
   Begin VB.Menu mnuJanelas 
      Caption         =   "&Janelas"
      WindowList      =   -1  'True
      Begin VB.Menu mnuOrganizarJanelas 
         Caption         =   "&Organizar Janelas"
         Begin VB.Menu mnuAutoOrganizarJanelas 
            Caption         =   "&Auto Organizar"
         End
         Begin VB.Menu mnuJanelasSeparador01 
            Caption         =   "-"
         End
         Begin VB.Menu mnuOrganizarJanelasSub 
            Caption         =   "Em &Cascata"
            Index           =   0
         End
         Begin VB.Menu mnuOrganizarJanelasSub 
            Caption         =   "Na &Horizontal"
            Index           =   1
         End
         Begin VB.Menu mnuOrganizarJanelasSub 
            Caption         =   "Na &Vertical"
            Index           =   2
         End
         Begin VB.Menu mnuOrganizarJanelasSub 
            Caption         =   "&Lado a Lado"
            Index           =   3
         End
      End
   End
End
Attribute VB_Name = "mdiMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public cn As ADODB.Connection


' Membros privados --
Private mBlnAutoOrganizarJanelas As Boolean
Private mFacAtualModoOrganizacaoJanelas As FormArrangeConstants

'--
' Propriedades
Public Property Get autoOrganizarJanelas() As Boolean
    autoOrganizarJanelas = mBlnAutoOrganizarJanelas
End Property

Public Property Let autoOrganizarJanelas(ByVal blnAutoOrganizarJanelas As Boolean)
    mBlnAutoOrganizarJanelas = blnAutoOrganizarJanelas
End Property

Public Property Get atualModoOrganizacaoJanelas() As FormArrangeConstants
     atualModoOrganizacaoJanelas = mFacAtualModoOrganizacaoJanelas
End Property

Public Property Let atualModoOrganizacaoJanelas(ByVal facAtualModoOrganizacaoJanelas As FormArrangeConstants)
     mFacAtualModoOrganizacaoJanelas = facAtualModoOrganizacaoJanelas
End Property

'--
Private Sub MDIForm_Load()

    
    mdiMain.mnuAbrir.Visible = False
    mdiMain.mnuSeparador05.Visible = False
    
    Call mdlUtilsCtrls.configurarCorDeFundo(Me)
           
    Set cn = mdlAcessoDados.obterConexao()
     
    App.Title = "AgendaRS - Versão " & App.Major & "." & Format$(App.Minor, "00") & IIf(App.Revision > 0, " Revisão " & Format$(App.Revision, "000"), "")
    
    Me.Caption = App.Title
    
End Sub

Private Sub MDIForm_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    
    Select Case UnloadMode
        ' Se clicado no botão fechar
        Case QueryUnloadConstants.vbFormControlMenu
            Cancel = True
            Me.Hide
            Load frmIconeBandeja
    End Select
End Sub

Private Sub MDIForm_Resize()
        
    If Me.WindowState = FormWindowStateConstants.vbMinimized Then
    
        Me.Hide
        Load frmIconeBandeja
        
    End If
    
End Sub

Private Sub MDIForm_Unload(Cancel As Integer)
    
    If MsgBox("Deseja finalizar o Aplicativo?", vbQuestion + vbYesNo + vbDefaultButton2) = vbNo Then
        Cancel = True
        Exit Sub
    End If
    
    End
    
End Sub

Private Sub mnuAbrir_Click()
    
    mdlIconeBandeja.removerIconeDaBandeja
    Me.WindowState = vbMaximized
    
    Me.Show
    
    
End Sub

Private Sub mnuAnotacao_Click()
    
    On Error GoTo TrataErro
        
    Call mdlIconeBandeja.removerIconeDaBandeja
    If Me.WindowState = vbMinimized Then
        Me.WindowState = vbMaximized
    End If
    frmAnotacao.Show
    
    If Me.autoOrganizarJanelas Then Arrange Me.atualModoOrganizacaoJanelas
    
    Exit Sub
TrataErro:
    MsgBox "Erro ao tentar abrir o formulário de anotações" & vbCrLf & Err.Number & vbCrLf & Err.Description, vbExclamation
End Sub

Private Sub mnuAutoOrganizarJanelas_Click()
    
    mnuAutoOrganizarJanelas.Checked = Not mnuAutoOrganizarJanelas.Checked
    
    Me.autoOrganizarJanelas = mnuAutoOrganizarJanelas.Checked
    
End Sub

Private Sub mnuDuvida_Click()
    
    Call mdlIconeBandeja.removerIconeDaBandeja
    If Me.WindowState = vbMinimized Then
        Me.WindowState = vbMaximized
    End If
    frmDuvida.Show
    
End Sub

Private Sub mnuOrganizarJanelasSub_Click(Index As Integer)
    
    Dim i As Integer
    
    Arrange Index
    
    Me.atualModoOrganizacaoJanelas = Index
    
    With mnuOrganizarJanelasSub
        For i = .LBound To .UBound
            .Item(i).Checked = (Index = i)
        Next
    End With
    
End Sub

Private Sub mnuPreferencias_Click()
    
    frmPreferencias.Show vbModal
    
End Sub

Private Sub mnuSair_Click()
    Call mdlIconeBandeja.removerIconeDaBandeja
    End
End Sub

Private Sub mnuSubCadastro_Click(Index As Integer)

    Dim f As IToolBarControles
    
    Select Case Index
        Case 0
            
            Call mdlIconeBandeja.removerIconeDaBandeja
            If Me.WindowState = vbMinimized Then
                Me.WindowState = vbMaximized
            End If
            frmContato.Show
            
            Set f = frmContato
            
            'f.limpar
            
    End Select
    
    If Me.autoOrganizarJanelas Then Arrange Me.atualModoOrganizacaoJanelas
    
End Sub

Private Sub mnuSugestao_Click()
    
    Call mdlIconeBandeja.removerIconeDaBandeja
    If Me.WindowState = vbMinimized Then
        Me.WindowState = vbMaximized
    End If
    
    frmSugestao.Show
    
End Sub

Private Sub mnuTarefas_Click()
    
    On Error GoTo TrataErro
    
    Call mdlIconeBandeja.removerIconeDaBandeja
    
    If Me.WindowState = vbMinimized Then
        Me.WindowState = vbMaximized
    End If
    
    frmTarefa.Show
    
    If Me.autoOrganizarJanelas Then Arrange Me.atualModoOrganizacaoJanelas
    
    Exit Sub
TrataErro:
    MsgBox "Erro ao tentar abrir o formulário de tarefas" & vbCrLf & Err.Number & vbCrLf & Err.Description, vbExclamation
End Sub

Private Sub mnuTipos_Click(Index As Integer)
    Dim f As New frmCadastroTipos
    
    f.NomeTipo = Replace(mnuTipos(Index).Caption, "&", "")
    
    f.Tipo = Index
    
    f.Show
    
    If Me.autoOrganizarJanelas Then Arrange Me.atualModoOrganizacaoJanelas
    
End Sub

Private Sub tbrMain_ButtonClick(ByVal Button As ComctlLib.Button)

    Dim f As IToolBarControles

    Select Case Button.Tag
        Case "atualizar"
            If Not ActiveForm Is Nothing Then
                If TypeOf ActiveForm Is IToolBarControles Then
                    Set f = ActiveForm
                    f.atualizar
                End If
            End If
        Case "limpar"
            If Not ActiveForm Is Nothing Then
                If TypeOf ActiveForm Is IToolBarControles Then
                    
                    Set f = ActiveForm
                    f.limpar
                End If
            End If
        Case "contato"
            mnuSubCadastro_Click (0)
        Case "tarefa"
            mnuTarefas_Click
        Case "anotacao"
            mnuAnotacao_Click
        Case "sugestao"
            mnuSugestao_Click
        Case "duvida"
            mnuDuvida_Click
        Case "sair"
            End
    End Select
End Sub
