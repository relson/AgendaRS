package br.com.agendr.rn.entidades;

public final class Stats {
	
	public static final String NAO_ININICIADO = "NAO_ININICIADO";
	public static final String EM_ANDAMENTO   = "EM_ANDAMENTO";
	public static final String PENDENTE       = "PENDENTE";
	public static final String CANCELADO      = "CANCELADO";
	public static final String FINALIZADO     = "FINALIZADO";
	
	public static boolean isStatusValid(String status){
		
		if(status.equalsIgnoreCase(NAO_ININICIADO) || status.equalsIgnoreCase(EM_ANDAMENTO) ||
		   status.equalsIgnoreCase(PENDENTE) || status.equalsIgnoreCase(CANCELADO)          ||
		   status.equalsIgnoreCase(FINALIZADO))
			
			return true;
			
		else
			
			return false;		
	}
}
