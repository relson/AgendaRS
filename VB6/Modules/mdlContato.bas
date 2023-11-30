Attribute VB_Name = "mdlContato"
Option Explicit

Public Const NOME_TABELA = "Contato"

Public Type TypeContato
    codigoContato As Long
    Nome As String
    sobreNome As String
End Type

Public Sub Excluir(ByVal lngCodigoContato As Long, lngCodigoNomeEntidade As Long, ByRef objLstLista As ListBox)
    
    Dim strSQL As String
    
    Dim strNomeEntidade As String
    Dim lngCodigoEntidade  As Long
    
    
    strNomeEntidade = obterNomeEntidade(lngCodigoNomeEntidade)
    
    With objLstLista
        lngCodigoEntidade = .ItemData(.ListIndex)
    End With
       
    
    strSQL = "DELETE FROM Contato" & strNomeEntidade & "s WHERE codigo" & strNomeEntidade & " = " & lngCodigoEntidade & " AND codigoContato = " & lngCodigoContato
    
    Call mdiMain.cn.Execute(strSQL)
        
End Sub

Public Function obterNomeEntidade(ByVal lngIndice As Long) As String
    
    Select Case lngIndice
        Case 1
            obterNomeEntidade = "Email"
        Case 2
            obterNomeEntidade = "Telefone"
        Case 3
            obterNomeEntidade = "Endereco"
    End Select
    
End Function

Public Sub excluirVinculosContato(ByVal lngCodigoContato As Long)
        
    Dim strEntidade As String
    Dim strSQL As String
    
    
    Dim i As Long
    
    For i = 1 To 3
    
        strEntidade = obterNomeEntidade(i)
        
        strSQL = "DELETE FROM Contato" & strEntidade & "s WHERE codigoContato = " & lngCodigoContato
        
        Call mdiMain.cn.Execute(strSQL)
        
    Next
    
End Sub

Public Sub excluirContato(ByVal lngCodigoContato As Long)
        
    Dim strSQL As String
        
    If lngCodigoContato = 0 Then Exit Sub
    
    mdiMain.cn.BeginTrans
    
    Call excluirVinculosContato(lngCodigoContato)
        
    strSQL = "DELETE FROM Contato WHERE codigoContato = " & lngCodigoContato
    
    Call mdiMain.cn.Execute(strSQL)
    
    mdiMain.cn.CommitTrans
End Sub
