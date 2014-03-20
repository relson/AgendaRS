package br.com.agendr.td;

public abstract class EntidadeDT implements Crud{
	
	public enum Entidade
	{
		CONTATO(0),
		EMAIL(1),
		TELEFONE(2),
		ENDERECO(3),
		OBSERVACAO(4),
		SITE(5);
		
		private final int value;
		
		Entidade(int indiceEntidade)
		{
			value = indiceEntidade;
		} // fim d construtor de um argumento
		
		public int getValue()
		{
			return value;
		} // fim do método getValue
		
		public String toString()
		{			
			return getNomeEntidades()[value];
		} // fim do método 
	}
	
	/**
	 * Obtém um array com nomes das entidades que tem <b>Tipo</b> correspondente
	 * @return String[] - array de nomes
	 */
	public static final String[] getNomeEntidades()
	{
		String nomes[] =
			{
				"contato",
				"email",
				"telefone",
				"endereco",
				"observacao",
				"site"								
			};
		return nomes;
	} // fim do metodo getNomeEntidades
} // fim da classe EntidadeDT