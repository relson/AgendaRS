Attribute VB_Name = "mdlAcessoDados"
' Sebastião Relson, sexta-feira, 4 de maio de 2007
'
' Módulo para acesso, manipulação e  persistêncida
' de dados.

Option Explicit

Private mCn As ADODB.Connection

Public Function obterSQLSelect(ByVal strLstTabela As String, ByRef strLstCampos() As String, Optional ByVal strCriterio As String) As String
    
    Dim strSQL As String
    Dim strDelimitador As String
    
    strDelimitador = vbTab & ", " & vbCrLf
    
    strSQL = " SELECT " & vbCrLf & _
                Join(strLstCampos, strDelimitador) & _
             " FROM " & _
                strLstTabela
    
    If Not Trim(strCriterio) = vbNullString Then
        
        strSQL = strSQL & " WHERE " & vbCrLf & strCriterio
                           
    End If
    
    obterSQLSelect = strSQL
    
End Function

Public Function obterRecordSet(ByVal strSQLSelect As String) As ADODB.Recordset
    
    Dim rs As ADODB.Recordset
    
    Set rs = New ADODB.Recordset
    rs.CursorLocation = adUseClient
    rs.Open strSQLSelect, obterConexao(), adOpenForwardOnly, adLockReadOnly
    
    Set obterRecordSet = rs
    
End Function

Public Function executarUpdate(ByVal strTabela As String, ByRef strLstCampos() As String, _
                               ByRef strLstValores() As String, Optional ByVal strCriterio As String) As Boolean
    
    Dim strSQLUpdate As String
    Dim i As Integer
    
    If UBound(strLstCampos) <> UBound(strLstValores) Then Err.Raise -2000000, "mdlAcessoDados - executarUpdate ", "Quantidade de Campos diferente da quantidade de valores."
    
    
    strSQLUpdate = " UPDATE " & strTabela & vbCrLf & _
                    vbTab & " SET " & vbCrLf
    
    
    For i = LBound(strLstCampos) To UBound(strLstCampos)
    
        strSQLUpdate = strSQLUpdate & strLstCampos(i) & " = " & strLstValores(i) & IIf(i < UBound(strLstCampos), ",", "") & vbCrLf
    
    Next
    
    If Not Trim(strCriterio) = vbNullString Then
        
        strSQLUpdate = strSQLUpdate & " WHERE " & vbCrLf & strCriterio
                           
    End If
    
    Call mCn.Execute(strSQLUpdate)
    
End Function

Public Function executarDelete(ByVal strTabela As String, ByVal strCriterio As String) As Boolean
    
    Dim strSQLDelete As String
        
    strSQLDelete = " DELETE FROM " & strTabela & vbCrLf & _
                    vbTab & " WHERE " & vbCrLf & strCriterio
    Call mCn.Execute(strSQLDelete)
End Function


Public Function obterConexao() As ADODB.Connection
    
    If mCn Is Nothing Then
        Call conectar
    End If
        
    Set obterConexao = mCn
    
End Function

Private Sub conectar()
        
    On Error GoTo Trata_Erro
    
    Dim strCn As String
    Dim strCaminho As String
    
    
    
    strCaminho = GetSetting(App.EXEName, "preferencias", "caminho_banco_dados", App.Path & "\db\db.mdb")
        
    If Dir(strCaminho) = vbNullString Then
        
        MsgBox "Não foi posssível encontrar o arquivo de banco de dados", vbExclamation
        
        frmPreferencias.Show vbModal
        
    End If
        
    
    strCn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
            "Data Source=" & strCaminho & ";" & _
            "Persist Security Info=False"
    
    Set mCn = New ADODB.Connection
        
    mCn.Open strCn
    
    Exit Sub
Trata_Erro:
    MsgBox "Erro ao tentar conectar ao banco de dados.", vbCritical
End Sub

Public Sub reconectar()
    
    Dim strCn As String
    Dim strCaminho As String
    
    
    
    strCaminho = GetSetting(App.EXEName, "preferencias", "caminho_banco_dados", App.Path & "\db\db.mdb")
        
    If Dir(strCaminho) = vbNullString Then
        
        MsgBox "Não foi posssível encontrar o arquivo de banco de dados", vbExclamation
        
        frmPreferencias.Show vbModal
        
    End If
        
    
    strCn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
            "Data Source=" & strCaminho & ";" & _
            "Persist Security Info=False"
    
    Set mCn = New ADODB.Connection
        
    mCn.Open strCn
    
    Exit Sub
Trata_Erro:
    MsgBox "Erro ao tentar conectar ao banco de dados." & vbCrLf & Err.Description, vbCritical
    
End Sub
