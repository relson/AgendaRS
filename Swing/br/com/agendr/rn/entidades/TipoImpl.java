package br.com.agendr.rn.entidades;

import br.com.agendr.td.TipoDT;

/**
 * Implementaçã para classe Tipo de forma genérica, passando apenas o nome do tipo no construtor da classe
 * 
 * @author Sebastião Relson
 *
 */
public class TipoImpl extends Tipo {
	
	private String nome;

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public TipoImpl(String nome)
	{
		setNome(nome);
	}
	
	public static Tipo[] getTipos(String nomeTipo) throws Exception
	{		
		return TipoDT.getTipos(nomeTipo);
	} // fim do método getTipos
	
	public void novo()
	{
		
		System.out.printf("Novo Tipo:\n %s\n %s", getNome(), getDescricao());
		
		try
		{
			TipoDT.novo(this);
		} // fim do try
		catch(Exception exception)
		{
			exception.printStackTrace();
		} // fim do cacth
		
	} // fim do método novo
	
	public void excluir()		
	{
		System.out.printf("Excluir Tipo %s:\n" +
				"Codigo: \t%d\n" +
				"Descrição: \t%s\n",
				getNome(),
				getCodigo(),				
				getDescricao());
		
		try
		{
			TipoDT.excluir(this);
		}
		catch(Exception exception)
		{
			exception.printStackTrace();
		}
		
	} // fim do método excluir
	
	public void atualizar()
	{
		System.out.printf("Atualizando Tipo:\n %s\n %s", getNome(), getDescricao());
		
		try
		{
			TipoDT.atualizar(this);
		} // fim do try
		catch (Exception exception)
		{
			exception.printStackTrace();
		}
		
	} // fim do método excluir
}
