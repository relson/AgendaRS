package br.com.agendr.td;

import br.com.agendr.ad.DbConnect;
import br.com.agendr.ad.DbCrud;

import br.com.agendr.rn.entidades.Telefone;

import com.sun.rowset.CachedRowSetImpl;

public class TelefoneDT extends EntidadeDT {

	public void atualizar() {
		// TODO implementar método

	}

	public void excluir() {
		// TODO implementar método

	}

	public void novo() throws Exception {
		// TODO implementar método

	}
	public static final Telefone[] getTelefones(int codigoContato) 
		throws Exception
	{
	
		try
		{
			
			Telefone telefones[];
			
			CachedRowSetImpl rowSet = DbConnect.postgresqlConnect();
			
			String campos[] = {
					"telefones.codigo",
					"telefones.telefone"
				};
			
			String tabela = String.format(
					"\t%1$s\n" +
					"INNER JOIN\n" +
					"\t%2$s\n" +
					"ON\n" +
					"\t%1$s.codigo = %2$s.%1$s_codigo\n" +
					"AND\n" +
					"\t%2$s.contatos_codigo = %3$d",
					"telefones",
					"contatos_has_telefones",
					codigoContato					
				); // fim da declaração da tabela
			
			DbCrud.select(rowSet,  tabela, campos);
			
			rowSet.last();
			
			telefones = new Telefone[rowSet.getRow()];
			// move o cursor para antes do primeiro registro
			rowSet.beforeFirst();
			
			int i = 0;
			
			while(rowSet.next())
			{
				
				int codigo = rowSet.getInt(1);
				String numero = rowSet.getString(2);
				
				telefones[i] = new Telefone();
				
				telefones[i].setCodigo(codigo);
				telefones[i].setNumero(numero);
				i++;
			} // fim do while
			
			return telefones;
		} // fim do try
		catch(Exception exception) {
			throw exception;
		} // fim do catch
	} // fim do método getEmails
} // fim da classe TelefoneDT
