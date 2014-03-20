package br.com.agendr.ad;


/*Classe que possiu metodos de manipulcao de dados
 * Todos metodos staticos 
 */



import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import com.sun.rowset.CachedRowSetImpl;


public class DbCrud {
	
	
	
	
	/**
	 *Metodo que insere um cadastro no banco 
	 *Metodo permite que insercao seja feita atraves do site ou local
	 *Metodo definido e testado
	 * @param conexao
	 * @param tableName
	 * @param fields
	 * @param values
	 * @throws Exception
	 */
	public static void insert(CachedRowSetImpl conexao, String tableName, String[] fields, String[] values) throws Exception{
		
		
		if(fields.length != values.length){
			throw new Exception("Quantidade de campos diferentes de quantidade de valores");
			
		}else{
			
			StringBuffer sql = new StringBuffer();
			
			sql.append(String.format("INSERT INTO %s (",tableName));
								
				for (String field : fields){
					sql.append(field);
					sql.append(", ");
					
				}
				
			sql.deleteCharAt(sql.length()-1);
			sql.deleteCharAt(sql.length()-1);
			
			sql.append(") values(");
			
				for(String value : values){				
				
					//Caso valor nao seja inteiro e levantada uma exceptoin a qual e inserido uma string a tabela
			
					try{
						Integer.parseInt(value);
						sql.append(value+", ");
					
					
						
					}catch(NumberFormatException nfex){
												
						sql.append("'"+value+"', ");
					}
					
					
					
				}
				sql.deleteCharAt(sql.length()-1);
				sql.deleteCharAt(sql.length()-1);
				sql.append(")");
		
		conexao.setCommand(sql.toString());
		conexao.execute();
			
		
		}
		
		
	}//Fim metodo insert
	
	
	
	
	
	
	/**
	 * Metodo que retorna um CachedRowSet com dados da select 
	 *Metodo permite que insercao seja feita atraves do site ou local
	 *Metodo definido e testado
	 * @param conexao
	 * @param tableName
	 * @param fields
	 * @param criteria
	 * @return
	 * @throws Exception
	 */
	public static CachedRowSetImpl  select(CachedRowSetImpl conexao, String tableName, String[] fields, String criteria) throws Exception{
			
				
		if(fields.length == 0){
			
			throw new Exception("Array nao contem campos para efetuar query ao banco");
			
		}else{
			
			StringBuffer sql = new StringBuffer();
			
			sql.append("SELECT\n");		
			
			for (String field : fields){
				
				sql.append("\t" + field +",\n");
								
			}
			
				
			sql.deleteCharAt(sql.length()-1);
			sql.deleteCharAt(sql.length()-1);
			
			sql.append("\nFROM\n"+tableName);
			
			if (! criteria.trim().isEmpty())			
				sql.append("WHERE\n"+criteria);
			
			
			
			conexao.setCommand(sql.toString());
			System.out.println(sql.toString());
		
								
			try{
				conexao.execute();
					
			
			}catch(SQLException sqle){
				throw new Exception("Erro em select: Verifique sintax SQL e conexao com o banco\n" + sqle.getMessage());
				
			}
						
			
		}	
		
		return conexao;
	}
	
	
	
	/**
	 *Metodo que retorna um CachedRowSet com dados da select 
	 *Metodo permite que uma query seja feita atraves do site ou local
	 *Metodo definido e testatdo
	 * @param conexao
	 * @param tableName
	 * @param fields
	 * @return
	 * @throws Exception
	 */
	public static CachedRowSetImpl  select(CachedRowSetImpl conexao, String tableName, String[] fields) throws Exception{
		
		return select(conexao, tableName, fields, "");  
	}
	
	
	
	
	/**
	 *Metodo que retorna valor verdadeiro caso valor for alterado no banco 
	 *Metodo permite que update seja feita atraves do site ou local
	 *Metodo Testatdo
	 * @param conexao
	 * @param tableName
	 * @param fields
	 * @param values
	 * @param criteria
	 * @return
	 * @throws Exception
	 */
	public static boolean update(CachedRowSetImpl conexao, String tableName, String[] fields, String[] values, String criteria) throws Exception{
		
		boolean response = false;
		
		if(fields.length == 0){
		
			throw new Exception("Array nao contem campos para select ao banco");
		
		}else{
		
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE "+tableName+" SET ");
			
			for(int i = 0; i < fields.length; i++){
				
				sql.append(fields[i]+" = ");
							
				
				try{					
					Integer.parseInt(values[i]);
					sql.append(values[i]+", ");
										
				}catch(NumberFormatException nfex){
					sql.append(String.format(" '%s', ",values[i]));
					
				}
							
			}
			
			sql.deleteCharAt(sql.length()-1);
			sql.deleteCharAt(sql.length()-1);
			
			sql.append(" WHERE "+criteria);
			conexao.setCommand(sql.toString());
			
			System.out.printf("\n%s\n", sql.toString());
			
			try{
						
				conexao.execute();
				response = true;
				
			}catch(SQLException sqle){
				throw new Exception("Erro ao atualizar: Verifique sintax SQL e conexao com o banco");
				
			}	
					
		}
		
	return response;	
	}
	
	
	
	/**
	 *Metodo que retorna valor verdadeiro caso valor for alterado no banco 
	 *Metodo permite que update seja feita atraves do site ou local
	 *Metodo Testatdo
	 * @param conexao
	 * @param tableName
	 * @param fields
	 * @param values
	 * @return
	 * @throws Exception
	 */
	public static boolean update(CachedRowSetImpl conexao, String tableName, String[] fields, String[] values) throws Exception{
		
		return update(conexao, tableName, fields, values, "true");
	}

	
	/*Metodos para recuperas nome dos campos das tabelas
	 * Metodo testado 
	 */
		
	public static String[] getTableFields(CachedRowSetImpl conexao, String tableName)throws Exception{
		
		conexao.setCommand("SELECT * FROM "+tableName);
		conexao.execute();
		
		ResultSetMetaData rs =   conexao.getMetaData();
		String[] names = new String[rs.getColumnCount()-1];
				
				
		//O valor de i e setado para uma para nao pegar a primeira coluna que e codigo (AutoNumber)
		for(int i = 0; i< rs.getColumnCount()-1; i++){
			names[i] =  rs.getColumnName(i+2);
		}
		
	 return names;	
	}
		
	public static boolean delete(CachedRowSetImpl conexao, String tableName, String criteria) throws Exception{
		
		boolean response = false;
		
		
		StringBuffer sql = new StringBuffer();
		sql.append(" DELETE FROM " + tableName );
								
		sql.append(" WHERE " + criteria);
		conexao.setCommand(sql.toString());
		
		try{
			System.out.println(sql);
			conexao.execute();
			response = true;
			
		}catch(SQLException sqle){
			throw new Exception("Erro ao exluir: Verifique sintax SQL e conexao com o banco \n" + sqle.getMessage());
			
		}
		return response;	
	}

}
