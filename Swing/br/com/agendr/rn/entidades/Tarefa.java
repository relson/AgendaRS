package br.com.agendr.rn.entidades;


/*Defini�oes da classe para acesso inser��o no banco tabela de tarefas
 * 
 * 
 * */


import java.sql.Date;
import java.util.GregorianCalendar;

import javax.sql.rowset.CachedRowSet;

	//ENUM utilizada para conter os status validos de uma tarefa
enum Status {NAO_INICIADO, EM_ANDAMENTO, PENDENTE, CANCELADO, FINALIZADO}	

public class Tarefa{
		
	//Variaveis referentes ao atributos de uma tarefa.
	private Status  status;
	private String titulo      = null;
	private String descr       = null;
	private int    horaInicial = 0;
	private int    horaFinal   = 0;
	private Date   dataInicial = null;
	private Date   dataFinal   = null;
	private int    tempo	   = 0;   
	CachedRowSet rowSet 	   = null; 	
	
	/*Uma nova instancia da clase Tarefas e cridada com o status de nao Iniciado
	 * O Status da tarefa nao pode ser alterado
	 */
	public Tarefa(){
			
		this.status = Status.NAO_INICIADO;
	}
	

	
	
/*****************************************
 * Getter and Setters
 * ****************************************/
	
	public Date getDataFinal() {
		return dataFinal;
	}


	public void setDataFinal(String dataFinal){
		
		int d = Integer.parseInt(dataFinal.substring(0,2));
        int m = Integer.parseInt(dataFinal.substring(2,4));
        int a = Integer.parseInt("20"+dataFinal.substring(4));
        
        this.dataFinal = new Date(new GregorianCalendar(a,m,d).getTimeInMillis());  

	}


	public String getDescr() {
		return descr;
	}


	public void setDescr(String descr) {
		this.descr = descr;
	}


	public int getHoraFinal() {
		return horaFinal;
	}


	public void setHoraFinal(int horaFinal) {
		this.horaFinal = horaFinal;
	}


	public int getHoraInicial() {
		return horaInicial;
	}


	public void setHoraInicial(int horaInicial) {
		this.horaInicial = horaInicial;
	}


	public String getStatus() {	
		return status.toString();
	}

	
	public int getTempo() {
		return tempo;
	}


	public void setTempo(int tempo) {
		this.tempo = tempo;
	}


	public String getTitulo() {
		return titulo;
	}


	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	

	public Date getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(String dataInicial) {
			
		int d = Integer.parseInt(dataInicial.substring(0,2));
        int m = Integer.parseInt(dataInicial.substring(2,4));
        int a = Integer.parseInt(dataInicial.substring(4));
        
        this.dataInicial = new Date(new GregorianCalendar(a,m,d).getTimeInMillis());  

	}

	

/*****************************************
* Getter and Setters
* ****************************************/

	
	//Metodo que verifica se Tarefa ja pode ser inserido no banco
	public boolean isTarefaValid(){
		
		if(dataFinal != null && titulo != null && descr != null &&
		   dataInicial != null && horaFinal  > 0 && horaInicial > 0  && tempo > 0){
			
			return true;
		}else{
			return false;
			
		}
			
	}

	
	
		

}

