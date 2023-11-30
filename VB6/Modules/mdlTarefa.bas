Attribute VB_Name = "mdlTarefa"
'no caso das sugestões não precisa de hora, só de data e não é alterável o campo.... na verdade nem precisa ser visivel, contando que conste a data quando eu olhar na sugestão.... kinem o status.
'da sugestão os status serão
'Sugestões
'- não sugerido (defu)
'- sugerido
'- sugerido nao aceito
'- sugerido aceito
'
'
'Dúvidas (os status serão) - nas duvidas eu preciso da data e da hora separada tipo (data da dúvida = a hora atual do computador) e a (data da resposta = vazio para a data e a hora atual do computador no momento em que responder) por que assim eu adiciono a data que for respondida
'- não iniciada (defú)
'- iniciada
'- respondida
'- pendente

'Se for possível coloca um botao daí aparecia a textbox debaixo pra poder responder, que daí ja aparecisa com a data e hora né!
'Em 08/06/07, Sebastião Relson <sebastiaorelson@systecinfo.com.br> escreveu:

'    Quais os status mobem, da dúvida e da sugestão linda.'

'    Vai precisar das datas e horas?
'

'

'--
'Grata!!
'Rharyê Santana

Option Explicit

Public Enum STATUS_TAREFA
     NAO_INICIADO = 0
     EM_ANDAMENTO = 1
     PENDENTE = 2
     CONCLUIDO = 3
     CANCELADA = 4
     ANOTACAO = 5
End Enum

Public Enum PrioridadeTarefaConstantes
    ptcAlta
    ptcNormal
    ptcBaixa
End Enum

Public Const NOME_TABELA = "Tarefa"

Public Type TypeTarefa
    codigoTarefa As Long
    status As STATUS_TAREFA
    prioridade As PrioridadeTarefaConstantes
    titulo As String
    Descricao As String
    inicio As Date
    limite As Date
End Type

Public Function inserir(ByVal strTitulo As String, _
        ByVal strDescricao As String, _
        ByVal stsTarefa As STATUS_TAREFA, _
        ByVal ptcPrioridade As PrioridadeTarefaConstantes, _
        ByVal dtaInicial As Date, _
        ByVal dtaLimite As Date, _
        ByVal hraInicial As Date, _
        ByVal hraLimite As Date) As Boolean
    
    On Error GoTo TrataErro

    Dim i As Integer
    Dim strSQL As String
    Dim strCampos As String
    Dim strValores As String
    
    strCampos = "codigoStatus, codigoPrioridade, dataInicio, horaInicial, dataLimite, horaLimite, titulo, descricao"
    strValores = stsTarefa & ", " & ptcPrioridade & ",#" & dtaInicial & "#,#" & hraInicial & "#,#" & dtaLimite & "#,#" & hraLimite & "#," & mdlUtils.aspas(strTitulo) & "," & mdlUtils.aspas(strDescricao)
    
    
    strSQL = "INSERT INTO Tarefa(" & strCampos & ") VALUES(" & strValores & ")"
    
    
    Call mdiMain.cn.Execute(strSQL, i)
    
    inserir = CBool(i)
    
    Exit Function
TrataErro:
    MsgBox "Erro ao tentar inserir uma nova tarefa" & vbCrLf & _
           "Número: " & Err.Number & vbCrLf & _
           "Descrição: " & Err.Description
End Function

Public Sub Excluir(ByVal codigoTarefa As Long)
    
    Dim strCriterio As String
    
    strCriterio = "codigoTarefa = " & codigoTarefa
    
    Call mdlAcessoDados.executarDelete(mdlTarefa.NOME_TABELA, strCriterio)
    
End Sub

Public Sub alterar(ByRef udtTarefa As TypeTarefa, ByRef udtTarefaEditada As TypeTarefa)
        
    Dim strCampos() As String
    Dim strValores() As String
    
    Dim strCriterio As String
    
    Call configurarArrayModificadoTarefas(udtTarefa, udtTarefaEditada, strCampos, strValores)
            
    strCriterio = "codigoTarefa = " & udtTarefa.codigoTarefa
            
    Call mdlAcessoDados.executarUpdate(mdlTarefa.NOME_TABELA, strCampos, strValores, strCriterio)
        
End Sub

Public Function obterUdtTarefa(ByVal lngCodigoTarefa As Long) As TypeTarefa

    Dim strSQL As String
    Dim rs As ADODB.Recordset
    
    Dim strLstCampos() As String
    Dim strCriterio As String
    
    Dim mUdtTarefa As TypeTarefa
    
    strLstCampos() = Split("codigoTarefa, codigoStatus, codigoPrioridade, dataInicio, horaInicial, dataLimite, horaLimite, titulo, descricao", ",")
    strCriterio = "codigoTarefa = " & lngCodigoTarefa
    
    
    strSQL = mdlAcessoDados.obterSQLSelect(mdlTarefa.NOME_TABELA, strLstCampos, strCriterio)
        
    Set rs = mdlAcessoDados.obterRecordSet(strSQL)
    
    If rs.RecordCount > 0 Then
    
        mUdtTarefa.codigoTarefa = rs.Fields("codigoTarefa").Value
        mUdtTarefa.titulo = rs.Fields("Titulo").Value
        mUdtTarefa.Descricao = rs.Fields("Descricao").Value
        mUdtTarefa.inicio = CDate(rs.Fields("dataInicio").Value & " " & rs.Fields("horaInicial").Value)
        mUdtTarefa.limite = CDate(rs.Fields("dataLimite").Value & " " & rs.Fields("horaLimite").Value)
        mUdtTarefa.status = rs.Fields("codigoStatus").Value
        mUdtTarefa.prioridade = rs.Fields("codigoPrioridade").Value
    End If
    
    obterUdtTarefa = mUdtTarefa
    
End Function

Public Sub configurarArrayModificadoTarefas(ByRef udtTarefa As TypeTarefa, ByRef udtTarefaEditada As TypeTarefa, _
                                            ByRef strCampos() As String, ByRef strValores() As String)
    Dim blnArrayIniciada As Boolean
    
    With udtTarefaEditada
    
        If .titulo <> udtTarefa.titulo Then
            
            Call mdlUtils.configurarArrayCampoValor("Titulo", mdlUtils.aspas(.titulo), _
                                                    strCampos, strValores, _
                                                    blnArrayIniciada)
            blnArrayIniciada = True
            
        End If
        
        If (.Descricao <> udtTarefa.Descricao) Then
            
            Call mdlUtils.configurarArrayCampoValor("Descricao", mdlUtils.aspas(.Descricao), _
                                                    strCampos, strValores, _
                                                    blnArrayIniciada)
            blnArrayIniciada = True
            
        End If
        
        ' Inicial
        ' Verifica se mudou o horário
        If (DateDiff("n", .inicio, udtTarefa.inicio) <> 0) Then
            
            Call mdlUtils.configurarArrayCampoValor("HoraInicial", "#" & Format$(.inicio, "hh:mm") & "#", _
                                                    strCampos, strValores, _
                                                    blnArrayIniciada)
            blnArrayIniciada = True
            
        End If
        
        ' Verifica se mudou o dia
        If (DateDiff("d", .inicio, udtTarefa.inicio) <> 0) Then
            
            Call mdlUtils.configurarArrayCampoValor("dataInicio", "#" & Format$(.inicio, "dd/MM/yyyy") & "#", _
                                                    strCampos, strValores, _
                                                    blnArrayIniciada)
            blnArrayIniciada = True
            
        End If
        
        ' Limite
        ' Verifica se mudou o horário
        If (DateDiff("n", .limite, udtTarefa.limite) <> 0) Then
            
            Call mdlUtils.configurarArrayCampoValor("HoraLimite", "#" & Format$(.limite, "hh:mm") & "#", _
                                                    strCampos, strValores, _
                                                    blnArrayIniciada)
            blnArrayIniciada = True
            
        End If
        
        ' Verifica se mudou o dia
        If (DateDiff("d", .inicio, udtTarefa.limite) <> 0) Then
            
            Call mdlUtils.configurarArrayCampoValor("DataLimite", "#" & Format$(.limite, "dd/MM/yyyy") & "#", _
                                                    strCampos, strValores, _
                                                    blnArrayIniciada)
            blnArrayIniciada = True
            
        End If
        
        If (.status <> udtTarefa.status) Then
        
            Call mdlUtils.configurarArrayCampoValor("codigoStatus", .status, _
                                                    strCampos, strValores, _
                                                    blnArrayIniciada)
            blnArrayIniciada = True
            
        End If
        
         If (.prioridade <> udtTarefa.prioridade) Then
        
            Call mdlUtils.configurarArrayCampoValor("codigoPrioridade", .prioridade, _
                                                    strCampos, strValores, _
                                                    blnArrayIniciada)
            blnArrayIniciada = True
            
        End If
    End With
End Sub

Public Function obterNomePrioridade(ByRef ptcPrioridade As PrioridadeTarefaConstantes) As String
    
    Dim strNome As String
    
    Select Case ptcPrioridade
        Case ptcAlta
            strNome = "Alta"
        Case ptcNormal
            strNome = "Normal"
        Case ptcBaixa
            strNome = "Baixa"
    End Select
    
    obterNomePrioridade = strNome
    
End Function
