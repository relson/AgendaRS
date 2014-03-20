package br.com.agendr.td;

import com.sun.rowset.CachedRowSetImpl;

import br.com.agendr.ad.DbConnect;
import br.com.agendr.ad.DbCrud;
import br.com.agendr.rn.entidades.Site;

public class SiteDT extends EntidadeDT {

	public SiteDT() {
		// TODO Implementar Método
	}

	public void atualizar() {
		// TODO Implementar Método

	}

	public void excluir() {
		// TODO Implementar Método

	}

	public void novo() throws Exception {
		// TODO Implementar método
	}
	
	public static final Site[] getSites(int codigoContato)
		throws Exception
	{
		try 
		{
			Site sites[];
			
			CachedRowSetImpl rowSet = DbConnect.postgresqlConnect();
			
			String campos[] = {
					"sites.codigo",
					"sites.site"
			}; // fim da declaração do vetor campos
			
			String tabela = String.format(
					"\t%1$s\n" +
					"INNER JOIN\n" +
					"\t%2$s\n" +
					"ON\n" +
					"\t%1$s.codigo = %2$s.%1$s_codigo\n" +
					"AND\n" +
					"\t%2$s.contatos_codigo = %3$d",
					"sites",
					"contatos_has_sites",
					codigoContato					
				); // fim da declaração da tabela
			
			DbCrud.select(rowSet, tabela, campos);
			
			// move o cursor para ultima linha
			rowSet.last();
			
			// e obtém o total de linhas para inicializar o vetor de sites
			sites = new Site[rowSet.getRow()];
			
			/* 
			 * move o cursor para antes da primeira linha de forma que seja
			 * possível então navegar a partir da da primeira linha
			 * 
			 */
			rowSet.beforeFirst();
			
			int i = 0;
			
			while (rowSet.next())
			{
				int codigo = rowSet.getInt(1);
				String endereco = rowSet.getString(2);
				
				sites[i] = new Site();
				
				sites[i].setCodigo(codigo);
				sites[i].setEndereco(endereco);
				
				i++;				
			} // fim do while
			
			return sites;
		} catch (Exception exception) {
			throw exception;
		} // fim do catch		
	} // fim do método getSites
} // fim 