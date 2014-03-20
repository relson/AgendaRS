package br.com.agendr.td;

import com.sun.rowset.CachedRowSetImpl;

import br.com.agendr.ad.DbConnect;
import br.com.agendr.ad.DbCrud;
import br.com.agendr.rn.entidades.Contato;
import br.com.agendr.rn.entidades.ContatoTipo;

public class ContatoDT extends EntidadeDT {	
	
	public static Contato[] getContatos() 
		throws Exception{
		
		try
		{
			
			Contato contatos[];
			
			CachedRowSetImpl rowSet = DbConnect.postgresqlConnect();
			
			String campos[] = {"codigo","nome", "sobrenome"};
			
			DbCrud.select(rowSet, "Contatos", campos);
			
			rowSet.last();
			
			contatos = new Contato[rowSet.getRow()];
			// move o cursor para antes do primeiro registro
			rowSet.beforeFirst();
			
			int i = 0;
			
			while(rowSet.next())
			{
				
				int codigo = rowSet.getInt(1);
				String nome = rowSet.getString(2);
				String sobrenome = rowSet.getString(3);
				
				contatos[i] = new Contato();
				
				contatos[i].setCodigo(codigo);
				contatos[i].setNome(nome);
				contatos[i].setSobrenome(sobrenome);
				i++;
			} // fim do while
			
			return contatos;
		} // fim do try
		catch(Exception exception) {
			throw exception;
		} // fim do catch
	} // fim do método getTipos
	public static void novo(Contato contato) throws Exception
	{
		
		CachedRowSetImpl rowSet = DbConnect.postgresqlConnect();
		
		String tabela = "contatos";
		String campos[] = {"nome", "sobrenome"};
		String valores[] = {contato.getNome(), contato.getSobrenome()};
		
		DbCrud.insert(rowSet, tabela,campos, valores);
		
		int codigo = 0;
		
		campos = new String[1];
		
		campos[0] = "MAX(codigo) AS codigo";
		
		DbCrud.select(rowSet, tabela, campos);
		
		if (rowSet.next())
			codigo = rowSet.getInt(1);
		
		ContatoTipo tipos[] = contato.getTipos();
		
		tabela = "tiposcontato_has_contatos";
		
		campos = new String[2];
		
		campos[0] = "tiposcontato_codigo";
		campos[1] = "contatos_codigo";
		
		valores = new String[2];
		
		for (ContatoTipo tipo:tipos)
		{
			
			valores[0] = String.format("%d", tipo.getCodigo());
			valores[1] = String.format("%d", codigo);
			
			DbCrud.insert(rowSet, tabela, campos, valores);
		} // fim do for
		
	} // fim do método "novo"
	
	public void novo()
	{
		
	}
	
	public void atualizar()
	{
		
	}
	
	public void excluir()
	{
		
	}
}
