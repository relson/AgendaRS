package br.com.agendr.ui;

import java.sql.SQLException;

import br.com.agendr.ad.DbConnect;
import br.com.agendr.ad.DbCrud;
import br.com.agendr.rn.entidades.Rss;

import com.sun.rowset.CachedRowSetImpl;


public class RssManager {
	
	/**
	 * Metodo que insere um novo RSS ao banco userId = 0 banco local userId = 1 web 
	 * @param titulo
	 * @param url
	 * @param userId
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws Exception
	 */
	public static void insertRss(String titulo, String url, int userId)throws SQLException, ClassNotFoundException, InstantiationException,
													  IllegalAccessException, Exception{
		

		String[] fields = {"titulo", "url"}; 
		String[] values = {titulo, url};
				
		if(userId == 0 && url != null){
			
			CachedRowSetImpl rowSet = DbConnect.postgresqlConnect();
			
			if(checkRss(rowSet, titulo, url) == false)
				DbCrud.insert(rowSet, "RSS", fields, values);
			
		}else if(userId > 0 && url != null){
			
			CachedRowSetImpl rowSet = DbConnect.mysqlConnect(); 
			
			if(checkRss(rowSet, titulo, url) == false)
				DbCrud.insert(rowSet, "RSS", fields, values);
		}else
			throw new Exception("O Objeto do tipo Tarefa n�o possui atributos necess�rios para inser��o.");
		
	}
	
	
	
	/**Metodo que verifica se ja existe um Rss no banco e retorna true ou false
	 * 
	 * @param titulo
	 * @param url
	 */
	public static boolean checkRss(CachedRowSetImpl conexao, String titulo, String url)throws Exception{
						
		DbCrud.select(conexao, "RSS", DbCrud.getTableFields(conexao, "RSS"),
				      String.format(" titulo = '%s' AND url = '%s'", titulo, url));		
		
		while(conexao.next()){
			if(conexao.getString("titulo").equalsIgnoreCase(titulo) && conexao.getString("url").equalsIgnoreCase(url))
				return true;
		}
			
		return false;
	}
	
	/**Metodo que configura um RSS pelo ID na tabela RSS
	 *  
	 * @param conexao
	 * @param codigo
	 */
	public static boolean configRSS(CachedRowSetImpl conexao, int codigo, Rss rss){
					
		String[] values = {rss.getTitulo(), rss.getUrl()};
		
		try{
			DbCrud.update(conexao, "RSS", DbCrud.getTableFields(conexao, "RSS"), values, "codigo = "+codigo);
			return true;
		}catch(Exception ex){
			
		}
				
		return false;
	}
		
	
	
	/**Metodo que retorna um Rss do banco 
	 * 
	 * @param conexao
	 * @param titulo
	 * @return
	 * @throws Exception
	 */
	public static Rss retriveRss(CachedRowSetImpl conexao, String titulo)throws Exception{
				
		String[] fields = {"titulo","url"}; 
		
		CachedRowSetImpl rs = DbCrud.select(conexao, "RSS", fields, " titulo = "+titulo); 
		Rss rss = new Rss();
		
		rss.setTitulo(rs.getString("titulo"));
		rss.setUrl(rs.getString("url"));
			
	return rss;
	}
	
}