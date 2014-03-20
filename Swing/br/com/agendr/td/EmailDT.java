package br.com.agendr.td;

import br.com.agendr.ad.DbConnect;
import br.com.agendr.ad.DbCrud;

import br.com.agendr.rn.entidades.Email;

import com.sun.rowset.CachedRowSetImpl;

public class EmailDT extends EntidadeDT {
	
	public static final String emailTabela = "emails"; 
	
	public EmailDT() {
		// TODO Implementar Construtor
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
	
	public static final Email[] getEmails(int codigoContato) 
		throws Exception
	{
	
		try
		{
			
			Email emails[];
			
			CachedRowSetImpl rowSet = DbConnect.postgresqlConnect();
			
			String campos[] = {
					"emails.codigo",
					"emails.email"
				};
			
			String tabela = String.format(
					"\t%1$s\n" +
					"INNER JOIN\n" +
					"\t%2$s\n" +
					"ON\n" +
					"\t%1$s.codigo = %2$s.%1$s_codigo\n" +
					"AND\n" +
					"\t%2$s.contatos_codigo = %3$d",
					"emails",
					"contatos_has_emails",
					codigoContato					
				); // fim da declaração da tabela
			
			DbCrud.select(rowSet,  tabela, campos);
			
			rowSet.last();
			
			emails = new Email[rowSet.getRow()];
			// move o cursor para antes do primeiro registro
			rowSet.beforeFirst();
			
			int i = 0;
			
			while(rowSet.next())
			{
				
				int codigo = rowSet.getInt(1);
				String endereco = rowSet.getString(2);
				
				emails[i] = new Email();
				
				emails[i].setCodigo(codigo);
				emails[i].setEndereco(endereco);
				i++;
			} // fim do while
			
			return emails;
		} // fim do try
		catch(Exception exception) {
			throw exception;
		} // fim do catch
	} // fim do método getEmails
} // fim da classe EmailDT
