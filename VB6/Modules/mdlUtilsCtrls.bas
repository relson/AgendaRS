Attribute VB_Name = "mdlUtilsCtrls"
Option Explicit

#If Win32 Then
    Declare Function SendMessage Lib "User32" Alias "SendMessageA" _
        (ByVal hWnd As Long, ByVal wMsg As Long, _
         ByVal wParam As Long, lParam As Any) As Long
#Else
    Declare Function SendMessage Lib "User" _
        (ByVal hWnd As Integer, ByVal wMsg As Integer, _
         ByVal wParam As Integer, lParam As Any) As Long
#End If

Public Enum enumModoOperacao
    emoInsercao
    emoAlteracao
End Enum

Public Sub centralizarFrame(ByRef frmFrame As Frame)
    frmFrame.Top = (frmFrame.Parent.Height / 2) - (frmFrame.Height / 2)
    frmFrame.Left = (frmFrame.Parent.Width / 2) - (frmFrame.Width / 2)
End Sub

Public Sub configurarCorDeFundo(ByRef objForm As Form)
    ' Função desativada
    'objForm.BackColor = GetSetting(App.EXEName, "preferencias", "cor_fundo", frmPreferencias.corFundoPadrao)
    
End Sub

Public Sub configurarListaTipo(ByRef indiceTipo As Integer, ByRef ctrLista As Control)
    Dim rs As New ADODB.Recordset
    Dim strSQL As String
    Dim i As Integer
    Dim strNome As String
    
    strNome = mdlUtilsTipo.obterNomeTipo(indiceTipo)
    
    strSQL = "  SELECT " & _
             "      codigo" & strNome & " AS codigo, " & _
             "      Descricao" & _
             "  FROM" & _
             "      " & strNome
    
    rs.Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
    
    ctrLista.Clear
    
    While Not rs.EOF
        With ctrLista
            Call .AddItem(rs.Fields("descricao").Value)
            .ItemData(.NewIndex) = rs.Fields("codigo").Value
        End With
        rs.MoveNext
    Wend
    If ctrLista.ListCount > 0 Then
        ctrLista.ListIndex = 0
    End If
End Sub


Public Sub limparMaskEdBox(ByRef objMaskEdBox As MaskEdBox)
    
    Dim strMask As String
    
    With objMaskEdBox
        strMask = .Mask
        .Mask = ""
        .Text = ""
        .Mask = strMask
    End With
End Sub
' Contribuição Dica de Tom Rocha <tom@systecinfo.com.br>
' http://www.macoratti.net/dica10.htm
' Adaptação Sebastião Relson
Public Sub tratarKeyPressComboBox(ByVal objCboBox As ComboBox, ByRef intKeyAscii As Integer)
    
    Dim lngListIndex As Long
    Dim FindString As String
    Const CB_ERR = (-1)
    Const CB_FINDSTRING = &H14C
    
    With objCboBox
    
        If intKeyAscii < 32 Or intKeyAscii > 127 Then Exit Sub
        
        If .SelLength = 0 Then
            FindString = .Text & Chr$(intKeyAscii)
        Else
            FindString = Left$(.Text, .SelStart) & Chr$(intKeyAscii)
        End If
        
        lngListIndex = SendMessage(.hWnd, CB_FINDSTRING, -1, ByVal FindString)
        
        If lngListIndex <> CB_ERR Then
            .ListIndex = lngListIndex
            .SelStart = Len(FindString)
            .SelLength = Len(.Text) - .SelStart
            intKeyAscii = 0
        Else
            If objCboBox.Style <> vbComboSimple Then
                intKeyAscii = 0
            End If
        End If
        
    End With
End Sub
