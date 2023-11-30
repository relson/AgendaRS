Attribute VB_Name = "mdlUtilsTipo"
Option Explicit

Public Sub gravarTipo(ByRef objTipo As ITipo)
        
    Dim rs As ADODB.Recordset
    Dim strSQL As String
    Dim strCodigo As String
    Dim i As Integer
    
    strSQL = "INSERT INTO " & objTipo.Nome & "(descricao) VALUES('" & _
              objTipo.Descricao & "')"
    
    Call mdiMain.cn.Execute(strSQL, i)
    
    strSQL = "SELECT max(codigo" & objTipo.Nome & ") as codigo FROM " & objTipo.Nome
        
    Set rs = mdiMain.cn.Execute(strSQL)
    
    strCodigo = Format$(rs.Fields("codigo").Value, "0000")
    
    objTipo.Codigo = strCodigo

End Sub

Public Function obterNomeTipo(ByVal indiceMenu As Integer)
    Select Case indiceMenu
        Case 0
            obterNomeTipo = "TipoContato"
        Case 1
            obterNomeTipo = "TipoEmail"
        Case 2
            obterNomeTipo = "TipoTelefone"
        Case 3
            obterNomeTipo = "TipoEndereco"
    End Select
End Function

Public Function ExcluirTipo(ByRef objTipo As ITipo)
    
    Dim strSQL As String
    
    If Not existeVicunculos(objTipo) Then
    
        With objTipo
            strSQL = "DELETE FROM " & .Nome & " WHERE codigo" & .Nome & " = " & .Codigo
                                    
            Call mdiMain.cn.Execute(strSQL)
        End With
    
    End If
    
End Function

Public Function AlterarTipo(ByRef objTipo As ITipo)
    
    Dim strSQL As String
    
    With objTipo
        strSQL = "UPDATE " & .Nome & " SET descricao = '" & .Descricao & "' WHERE codigo" & .Nome & " = " & .Codigo
    End With
    
    Call mdiMain.cn.Execute(strSQL)
    
End Function

Private Function existeVicunculos(ByRef objTipo As ITipo) As Boolean

    Dim strEntidade As String
    Dim strNomeEntidade As String
    Dim strNomeCampo As String
    Dim strSQL As String
    Dim strMsg As String
    
    
    Dim rs As New ADODB.Recordset
    
    Dim strListaEntidade As String
    
    With objTipo
        strEntidade = Right(.Nome, Len(.Nome) - 4)
    End With
       
    strNomeCampo = NomeCampoDescricaoEntidade(strEntidade)
    strNomeEntidade = NomeEntidade(strEntidade)
    
    If strEntidade = "Contato" Then
        strSQL = " SELECT " & _
                        strEntidade & "." & strNomeCampo & _
                 " FROM " & _
                        strEntidade & ", " & _
                        strEntidade & "Tipos, " & _
                        objTipo.Nome & _
                 " WHERE " & _
                    strEntidade & ".codigo" & strEntidade & " = " & strEntidade & "Tipos.codigo" & strEntidade & " AND " & _
                    objTipo.Nome & ".codigo" & objTipo.Nome & " = " & strEntidade & "Tipos.codigo" & objTipo.Nome & " AND " & _
                    objTipo.Nome & ".codigo" & objTipo.Nome & " = " & objTipo.Codigo
    Else
        strSQL = " SELECT " & _
                       strEntidade & "." & strNomeCampo & _
                " FROM " & _
                       strEntidade & ", " & _
                       objTipo.Nome & _
                " WHERE " & _
                   strEntidade & ".codigo" & objTipo.Nome & " = " & objTipo.Nome & ".codigo" & objTipo.Nome & " AND " & _
                   objTipo.Nome & ".codigo" & objTipo.Nome & " = " & objTipo.Codigo
    End If
    
    If rs.State <> 0 Then rs.Close
    rs.CursorLocation = adUseClient
    rs.Open strSQL, mdiMain.cn, adOpenForwardOnly, adLockReadOnly
    
    
    If Not rs.EOF Then
            
        strListaEntidade = rs.GetString(, , , ";" & vbCrLf)
        
        strMsg = "Não será possível excluir o tipo porque os " & strNomeEntidade & ": " & vbCrLf & strListaEntidade & "Estão vinculados ao tipo " & objTipo.Descricao & "."
        
        'strMsg = "Os " & strNomeEntidade & ": " & vbCrLf & strListaEntidade & "Estão vinculados ao tipo " & objTipo.Descricao & ". " & vbCrLf & "Deseja Reclassifica-los para continuar com a exclusão?"
        
        If MsgBox(strMsg, vbExclamation) = vbYes Then
        
        'If MsgBox(strMsg, vbQuestion + vbYesNo) = vbYes Then
            
            Dim f As New frmReclassificarTipo
            Dim lngCodigoTipoAnterior As Long
            
            f.lblMensagem = "Atualizar " & strNomeEntidade & " classificados como """ & objTipo.Descricao & """ para:"
            
            If f.Reclassificar(objTipo) Then
                
                    If strEntidade = "Contato" Then
                        strSQL = " SELECT " & _
                                        strEntidade & "." & strNomeCampo & _
                                 " FROM " & _
                                        strEntidade & ", " & _
                                        strEntidade & "Tipos, " & _
                                        objTipo.Nome & _
                                 " WHERE " & _
                                    strEntidade & ".codigo" & strEntidade & " = " & strEntidade & "Tipos.codigo" & strEntidade & " AND " & _
                                    objTipo.Nome & ".codigo" & objTipo.Nome & " = " & strEntidade & "Tipos.codigo" & objTipo.Nome & " AND " & _
                                    objTipo.Nome & ".codigo" & objTipo.Nome & " = " & objTipo.Codigo
                    Else
                        strSQL = " SELECT " & _
                                strEntidade & "." & strNomeCampo & _
                         " FROM " & _
                                strEntidade & ", " & _
                                strEntidade & "Tipos, " & _
                                objTipo.Nome & _
                         " WHERE " & _
                            strEntidade & ".codigo" & strEntidade & " = " & strEntidade & "Tipos.codigo" & strEntidade & " AND " & _
                            objTipo.Nome & ".codigo" & objTipo.Nome & " = " & strEntidade & "Tipos.codigo" & objTipo.Nome & " AND " & _
                            objTipo.Nome & ".codigo" & objTipo.Nome & " = " & objTipo.Codigo
                
                    End If
                existeVicunculos = False
            End If
        Else
            existeVicunculos = True
        End If
    End If
End Function

Private Function NomeEntidade(ByVal strEntidade) As String
    Select Case strEntidade
        Case "Contato"
            NomeEntidade = "Contatos"
        Case "Email"
            NomeEntidade = "e-mails"
        Case "Telefone"
            NomeEntidade = "Telefones"
        Case "Endereco"
            NomeEntidade = "Endereços"
    End Select
End Function

Private Function NomeCampoDescricaoEntidade(ByVal strEntidade As String) As String
    
    Dim strNome As String
    
    Select Case strEntidade
        Case "Endereco", "Email"
            strNome = "endereco"
        Case "Telefone"
            strNome = "numero"
        Case "Contato"
            strNome = "nome"
    End Select
    
    NomeCampoDescricaoEntidade = strNome
    
End Function

Public Function obterIndiceTipo(ByVal strNomeTipo As String) As Integer
    Select Case strNomeTipo
        Case "TipoContato"
           obterIndiceTipo = 0
        Case "TipoEmail"
           obterIndiceTipo = 1
        Case "TipoTelefone"
           obterIndiceTipo = 2
        Case "TipoEndereco"
           obterIndiceTipo = 3
    End Select
End Function
