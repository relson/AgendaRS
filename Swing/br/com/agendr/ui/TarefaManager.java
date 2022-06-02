package br.com.agendr.ui;

import java.sql.SQLException;

import javax.sql.rowset.CachedRowSet;

import br.com.agendr.ad.DbConnect;
import br.com.agendr.ad.DbCrud;
import br.com.agendr.rn.entidades.Stats;
import br.com.agendr.rn.entidades.Tarefa;

public class TarefaManager {

	
	
	
	/*Metodo que insere tarefa ao banco passando u id do usuario
	 * Caso userId seja 0 entao e inserido no banco local
	 * Metodo Testado
	 */ 

	public static void insertTarefa(Tarefa tarefa, int userId)throws SQLException, ClassNotFoundException, InstantiationException,
   									IllegalAccessException, Exception{
	
	
	//Caso objeto do tipo Tarefa nao possua todos atributos nao pode ser inserido
	if(!tarefa.isTarefaValid()){
		
		throw new Exception("O Objeto do tipo Tarefa não possui atributos necessários para inserção.");
				
	//Se objeto e valido e o banco nao e web entao objeto é inserido 	
	}else if(tarefa.isTarefaValid()){
		
		String[] values = new String[8];
		
		values[0] = tarefa.getStatus();
		values[1] = tarefa.getTitulo();
		values[2] = tarefa.getDescr();
		values[3] = String.valueOf(tarefa.getHoraFinal());
		values[4] = tarefa.getDataFinal().toString();
		values[5] = String.valueOf(tarefa.getTempo());
		values[6] = tarefa.getDataInicial().toString();
		values[7] = String.valueOf(tarefa.getHoraInicial());
			
		if(userId == 0){
			 
			CachedRowSet rowSet = DbConnect.postgresqlConnect();
			//Insere uma nova tarefa
			DbCrud.insert(rowSet, "Tarefas", DbCrud.getTableFields(rowSet, "Tarefas"), values);	 
		
		}else if(userId > 0){
			
		
			String[] fields     = {"codigo"};						
			
			CachedRowSet rowSet = DbConnect.mysqlConnect(); 
			
			//Insere uma nova tarefa
			DbCrud.insert(rowSet, "Tarefas", DbCrud.getTableFields(rowSet, "Tarefas"), values);
			
			//Recolhe o id da tarefa inserida
			CachedRowSet rs = DbCrud.select(rowSet, "Tarefas", fields, String.format(
									   " titulo = '%s' AND descricao = '%s' AND hora_final = %s", tarefa.getTitulo(),
									   tarefa.getDescr(), tarefa.getHoraFinal()));
					
			
			rs.next();
			rs.getInt("codigo");
						
			String [] valores = {String.valueOf(userId), String.valueOf(rs.getInt(1))};
			String [] campos  = {"Usuarios_codigo","Tarefas_codigo"};
			
			//Insercao de tarefa do Usuario na Tabela Usuarios_has_tarefas
			DbCrud.insert(rowSet, "usuarios_has_tarefas", campos, valores);
			
		}
		
	}
				
	}



	/**Overloaded insertTarefa(Tarefa tarefa, int userId)
	 *  
	 * @param tarefa
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws Exception
	 */

	public static void insertTarefa(Tarefa tarefa)throws SQLException, ClassNotFoundException, InstantiationException,
																IllegalAccessException, Exception{
		insertTarefa(tarefa, 0);
				
	}






	/*Metodo que muda status da tarefa
	 *Metodo Testado
	 * 
	 */

	public static void changeTarefaStatus(CachedRowSet conexao, Tarefa tarefa, String status)throws Exception {
						
		if(Stats.isStatusValid(status) && tarefa != null && status != null){
			
			String[] fields     = {"Status_statusTarefas"};
			String[] values     = {status};
				
			
			String criteria = String.format(
					   " titulo = '%s' AND descricao = '%s' AND hora_final = %s", tarefa.getTitulo(),
				       tarefa.getDescr(), tarefa.getHoraFinal());
										
			DbCrud.update(conexao, "Tarefas", fields, values, criteria);	
			
		}else
			throw new Exception("Status invalido");
		
	
	
	}
	
	
	/*Metodo que muda o status da tarefa atraves do codigo ta tarefa
	 *Metodo testado
	 */
	
	
	public static void changeTarefaStatus(CachedRowSet conexao, int codigo, String status)throws Exception {
		
		if(Stats.isStatusValid(status)){
			
			String[] fields     = {"Status_statusTarefas"};
			String[] values     = {status};
				
			
			String criteria = " codigo = "+codigo;
										
			DbCrud.update(conexao, "Tarefas", fields, values, criteria);	
			
		}else
			throw new Exception("Status invalido");
		
	
	
	}
	
	/*Metodo que altera todos os parametros de uma tarefa 
	 *Recebe as antigas configuracoes e subustutues pelas novas
	 */
	
	public static void configTarefa(CachedRowSet conexao, Tarefa oldTarefa, Tarefa newTarefa) throws Exception{
		
		if(oldTarefa != null && newTarefa != null && conexao != null && newTarefa.isTarefaValid()){
			
			String[] fields = DbCrud.getTableFields(conexao, "Tarefas");
			
			String[] values = {newTarefa.getStatus(), newTarefa.getTitulo(), newTarefa.getDescr(),
							   String.valueOf(newTarefa.getHoraFinal()), newTarefa.getDataFinal().toString(),
							   String.valueOf(newTarefa.getTempo()), newTarefa.getDataInicial().toString(),
							   String.valueOf(newTarefa.getHoraInicial())};
			
			
			
			String criteria = String.format(
							  " Status_statusTarefas = '%s' AND titulo = '%s' AND descricao = '%s'" +
							  " AND hora_final = %s" , oldTarefa.getStatus(), oldTarefa.getTitulo(),
							  oldTarefa.getDescr(), String.valueOf(oldTarefa.getHoraFinal()));
			
			
			
			DbCrud.update(conexao, "Tarefas", fields, values, criteria);
						
			
		}else
			throw new Exception("Objeto tarefa nao e valido para insercao");
		
		
	}
	
	
	
	/*Metodo que altera todos os parametros de uma tarefa 
	 *Recebe as novas configuracoes para tarefa com o codigo especifico
	 */
	public void configTarefa(CachedRowSet conexao, int codigo, Tarefa tarefa)throws Exception{
		
		if(tarefa != null && conexao != null && tarefa.isTarefaValid()){
			
			String[] fields = DbCrud.getTableFields(conexao, "Tarefas");
			
			String[] values = {tarefa.getStatus(), tarefa.getTitulo(), tarefa.getDescr(),
							   String.valueOf(tarefa.getHoraFinal()), tarefa.getDataFinal().toString(),
							   String.valueOf(tarefa.getTempo()), tarefa.getDataInicial().toString(),
							   String.valueOf(tarefa.getHoraInicial())};
			
			String criteria = " codigo = "+String.valueOf(codigo);
			
			DbCrud.update(conexao, "Tarefas", fields, values, criteria);
				
			
		}else
			throw new Exception("Objeto tarefa nao e valido para insercao");
				
	}
	

	
	
}
