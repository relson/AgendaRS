package br.com.agendr.ad;

import java.sql.SQLException;

import com.sun.rowset.CachedRowSetImpl;

public class DbConnect {
	
	public static CachedRowSetImpl dbConnect(String dbType, String dbName, String url, String user, String password)
								   throws SQLException, ClassNotFoundException, InstantiationException,
								   IllegalAccessException{

		String dbase = "";
				
		CachedRowSetImpl rowSet =  new CachedRowSetImpl();
				
		if(dbType.equalsIgnoreCase("mysql")){
			
			dbase = "jdbc:mysql://"+url+"/"+dbName;						
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			
		}else if(dbType.equalsIgnoreCase("postgresql")){
			
			dbase = "jdbc:postgresql://"+url+"/"+dbName;
			
		}else{
			throw new InstantiationException("Banco nao especificado corretamente");						
		}
		   	
		rowSet.setUrl(dbase);
		rowSet.setUsername(user);
		rowSet.setPassword(password);       

	return rowSet;
	}
	
	
	//Metodo que conecta ao banco local mySql
	public static CachedRowSetImpl mysqlConnect() throws SQLException, ClassNotFoundException,
												  InstantiationException, IllegalAccessException{
	
	CachedRowSetImpl rowSet =  new CachedRowSetImpl();	
		
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	rowSet.setUrl("jdbc:mysql://localhost/agendr");
	rowSet.setUsername("site");
	rowSet.setPassword("123456");       
			
	
	return rowSet;	
	}
	
	
	//Metodo que conecta ao banco local PostgreSql
	public static CachedRowSetImpl postgresqlConnect() throws SQLException, ClassNotFoundException,
	  												InstantiationException, IllegalAccessException{

		CachedRowSetImpl rowSet =  new CachedRowSetImpl();	

		Class.forName("org.postgresql.Driver").newInstance();
		rowSet.setUrl("jdbc:postgresql://localhost/agendr");
		rowSet.setUsername("bach");
		rowSet.setPassword("bach");       
		return rowSet;	
}
	
	
}
