Attribute VB_Name = "mdlUtils"
Option Explicit

Public Function aspas(ByVal strValor As String) As String
    On Error GoTo TrataErro
    
    aspas = "'" & Replace(strValor, "'", "''") & "'"
    
    Exit Function
TrataErro:
End Function



Public Sub configurarArrayCampoValor(ByVal strCampo As String, ByVal strValor As String, _
                                     ByRef strCampos() As String, strValores() As String, _
                                     blnArrayIniciada As Boolean)
    
    Dim i As Integer
    
    If blnArrayIniciada Then
    
        i = UBound(strCampos) + 1
        
        ReDim Preserve strCampos(i), strValores(i)
        
        strCampos(i) = strCampo: strValores(i) = strValor
    
    Else
        
        ReDim strCampos(0), strValores(0)
        
        strCampos(0) = strCampo: strValores(0) = strValor
    End If
    
End Sub


