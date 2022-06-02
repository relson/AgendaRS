package br.com.agendr.ui;

import java.sql.SQLException;

import br.com.agendr.ad.DbConnect;
import br.com.agendr.rn.entidades.Tarefa;

import javax.sql.rowset.CachedRowSet;

public class Test {
	
	public static void main(String args[]) throws SQLException{
			
			
		Tarefa tarefa = new Tarefa();
		
		tarefa.setTitulo("Titulo");
		tarefa.setDescr("descricao");
		tarefa.setHoraFinal(1500);
		tarefa.setDataFinal("100407");		
		tarefa.setDataInicial("090807");
		tarefa.setHoraInicial(1200);
		tarefa.setTempo(5);
			
		
		Tarefa newTarefa = tarefa;
		newTarefa.setTempo(10);
		newTarefa.setDataFinal("110407");
		
		
		try{
			
			CachedRowSet conexao = DbConnect.postgresqlConnect();
			
			TarefaManager.configTarefa(conexao, tarefa, newTarefa);
			TarefaManager.insertTarefa(newTarefa);
			
			
		}catch(Exception e){
			
		   System.out.println(e.toString());
		   e.printStackTrace();	
		   
		}finally{
			System.out.println("The End.");
		}
		
		
		
	}

}
