package br.com.agendr.rn.entidades;

public class Observacao extends Entidade 
{
	private String descricao;

	public String getDescricao() {
		return descricao;
	} // fim do método getDescricao
	
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	} // fim do método setDescricao
	
	public String toString()
	{
		return getDescricao() + " (Não classificada)";
	} // fim do método
} // fim da classe observacao
