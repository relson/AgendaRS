package br.com.agendr.td;
import javax.sql.rowset.CachedRowSet;

import br.com.agendr.ad.DbConnect;
import br.com.agendr.ad.DbCrud;
import br.com.agendr.rn.entidades.Tipo;
import br.com.agendr.rn.entidades.TipoImpl;

public class TipoDT  {
	
	/**
	 * 
	 * @param nomeTipo
	 * @return Array de Tipo qualificado de acordo com o parametro nomeTipo
	 * @throws Exception
	 */
	public static final Tipo[] getTipos(String nomeTipo) 
		throws Exception{
		
		try
		{
			
			Tipo tipos[];
			
			CachedRowSet rowSet = DbConnect.postgresqlConnect();
			
			String campos[] = {"codigo","descricao"};
			
			DbCrud.select(rowSet, nomeTipo, campos);
			
			rowSet.last();
			
			tipos = new Tipo[rowSet.getRow()];
			// move o cursor para antes do primeiro registro
			rowSet.beforeFirst();
			
			int i = 0;
			
			while(rowSet.next())
			{
				
				int codigo = rowSet.getInt(1);
				String descricao = rowSet.getString(2);
				
				tipos[i] = new TipoImpl(nomeTipo);
				
				tipos[i].setCodigo(codigo);
				tipos[i].setDescricao(descricao);
				i++;
			} // fim do while
			
			return tipos;
		} // fim do try
		catch(Exception exception) {
			throw exception;
		} // fim do catch
	} // fim do método getTipos
	
	public static void excluir(TipoImpl tipo) 
		throws Exception
	{
		
		CachedRowSet rowSet = DbConnect.postgresqlConnect();
		
		String tabela = tipo.getNome();
		
		String criterio = String.format("%s.codigo = %d",
				tabela,
				tipo.getCodigo());
		
		DbCrud.delete(rowSet, tabela, criterio);		
		
	} // fim do método excluir
	
	
	public static void novo(TipoImpl tipo)
		throws Exception
	{
		CachedRowSet rowSet = DbConnect.postgresqlConnect();
		
		String tabela = tipo.getNome();
		
		String campos[] = {"descricao"};
		String valores[] = new String[1];
		
		valores[0] = tipo.getDescricao();
		
		DbCrud.insert(rowSet, tabela, campos, valores);
		
	} // fim do método novo
	
	public static void atualizar(TipoImpl tipo)
		throws Exception
	{
		CachedRowSet rowSet = DbConnect.postgresqlConnect();
		
		String tabela = tipo.getNome();
		
		String campos[] = {"descricao"};
		String valores[] = new String[1];
		
		String criterio = String.format("%s.codigo = %d",
				tipo.getNome(),
				tipo.getCodigo()
			);
		
		valores[0] = tipo.getDescricao();
		
		DbCrud.update(rowSet, tabela, campos, valores, criterio);
	} // fim do método atualizar
	
} // fim da classe TipoDT
