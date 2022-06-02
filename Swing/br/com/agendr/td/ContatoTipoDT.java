package br.com.agendr.td;

import javax.sql.rowset.CachedRowSet;

import br.com.agendr.ad.DbConnect;
import br.com.agendr.ad.DbCrud;
import br.com.agendr.rn.entidades.ContatoTipo;

public class ContatoTipoDT extends TipoDT {
	
	public static final ContatoTipo[] getTipos(int codigoContato) 
	throws Exception{
	
		try
		{
			
			ContatoTipo tipos[];
			
			CachedRowSet rowSet = DbConnect.postgresqlConnect();
			
			String campos[] = {
					"tiposcontato.codigo",
					"tiposcontato.descricao"
				};
			
			String tabela = String.format(
					"\t%1$s\n" +
					"INNER JOIN\n" +
					"\t%2$s\n" +
					"ON\n" +
					"\t%1$s.codigo = %2$s.%1$s_codigo\n" +
					"AND\n" +
					"\t%2$s.contatos_codigo = %3$d",
					"tiposcontato",
					"tiposcontato_has_contatos",
					codigoContato
					
				);
			
			DbCrud.select(rowSet,  tabela, campos);
			
			rowSet.last();
			
			tipos = new ContatoTipo[rowSet.getRow()];
			// move o cursor para antes do primeiro registro
			rowSet.beforeFirst();
			
			int i = 0;
			
			while(rowSet.next())
			{
				
				int codigo = rowSet.getInt(1);
				String descricao = rowSet.getString(2);
				
				tipos[i] = new ContatoTipo();
				
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
} // fim da classe ContatoTipoDT
