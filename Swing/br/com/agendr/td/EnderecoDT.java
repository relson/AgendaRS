package br.com.agendr.td;

import br.com.agendr.ad.DbConnect;
import br.com.agendr.ad.DbCrud;
import br.com.agendr.rn.entidades.Endereco;

import javax.sql.rowset.CachedRowSet;

public class EnderecoDT extends EntidadeDT {

	public void atualizar() {
		// TODO implementar método

	}

	public void excluir() {
		// TODO implementar método

	}

	public void novo() throws Exception {
		// TODO implementar método

	}
	public static final Endereco[] getEnderecos(int codigoContato) 
		throws Exception
	{	
		try
		{			
			Endereco  enderecos[];
			
			CachedRowSet rowSet = DbConnect.postgresqlConnect();
			
			String campos[] = {
					"enderecos.codigo",
					"enderecos.rua",
					"enderecos.complemento",
					"enderecos.bairro",
					"enderecos.cep",
					"enderecos.cidade",
					"enderecos.estado",
					"enderecos.pais"
				};
			
			String tabela = String.format(
					"\t%1$s\n" +
					"INNER JOIN\n" +
					"\t%2$s\n" +
					"ON\n" +
					"\t%1$s.codigo = %2$s.%1$s_codigo\n" +
					"AND\n" +
					"\t%2$s.contatos_codigo = %3$d",
					"enderecos",
					"contatos_has_enderecos",
					codigoContato					
				); // fim da declaração da tabela
			
			DbCrud.select(rowSet,  tabela, campos);
			
			rowSet.last();
			
			enderecos= new Endereco[rowSet.getRow()];
			// move o cursor para antes do primeiro registro
			rowSet.beforeFirst();
			
			int i = 0;
			
			while(rowSet.next())
			{
				
				int codigo = rowSet.getInt(1);
				String rua = rowSet.getString(2);
				String complemento = rowSet.getString(3);
				String bairro = rowSet.getString(4);
				String cep = rowSet.getString(5);
				String cidade = rowSet.getString(6);
				String estado = rowSet.getString(7);
				String pais = rowSet.getString(8);
								
				enderecos[i] = new Endereco();
				
				enderecos[i].setCodigo(codigo);
				enderecos[i].setRua(rua);
				enderecos[i].setComplemento(complemento);
				enderecos[i].setBairro(bairro);
				enderecos[i].setCep(cep);
				enderecos[i].setCidade(cidade);
				enderecos[i].setEstado(estado);
				enderecos[i].setPais(pais);
				i++;
			} // fim do while
			
			return enderecos;
		} // fim do try
		catch(Exception exception) {
			throw exception;
		} // fim do catch
	} // fim do método getEnderecos
}