package br.com.agendr.td;

import br.com.agendr.ad.DbConnect;
import br.com.agendr.ad.DbCrud;
import br.com.agendr.rn.entidades.Observacao;

import javax.sql.rowset.CachedRowSet;

public class ObservacaoDT extends EntidadeDT {

	public ObservacaoDT() {
		// TODO Auto-generated constructor stub
	}

	public void atualizar() {
		// TODO Auto-generated method stub

	}

	public void excluir() {
		// TODO Auto-generated method stub

	}

	public void novo() throws Exception {
		// TODO Auto-generated method stub

	}
	public static final Observacao[] getObservacoes(int codigoContato) 
		throws Exception
	{
	
		try
		{
			
			Observacao observacoes[];
			
			CachedRowSet rowSet = DbConnect.postgresqlConnect();
			
			String campos[] = {
					"observacoes.codigo",
					"observacoes.observacoes"
				};
			
			String tabela = String.format(
					"\t%1$s\n" +
					"INNER JOIN\n" +
					"\t%2$s\n" +
					"ON\n" +
					"\t%1$s.codigo = %2$s.%1$s_codigo\n" +
					"AND\n" +
					"\t%2$s.contatos_codigo = %3$d",
					"observacoes",
					"contatos_has_observacoes",
					codigoContato					
				); // fim da declaração da tabela
			
			DbCrud.select(rowSet,  tabela, campos);
			
			rowSet.last();
			
			observacoes = new Observacao[rowSet.getRow()];
			// move o cursor para antes do primeiro registro
			rowSet.beforeFirst();
			
			int i = 0;
			
			while(rowSet.next())
			{
				
				int codigo = rowSet.getInt(1);
				String descricao = rowSet.getString(2);
				
				observacoes[i] = new Observacao();
				
				observacoes[i].setCodigo(codigo);
				observacoes[i].setDescricao(descricao);
				i++;
			} // fim do while
			
			return observacoes;
		} // fim do try
		catch(Exception exception) {
			throw exception;
		} // fim do catch
	} // fim do método getObservacoes
} // fim da classe ObservacaoDT
