package br.com.agendr.rn.entidades;

public class Site extends Entidade {
	
	private String endereco;

	public String getEndereco() {
		return endereco;
	}

	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}
	
	public String toString()
	{
		return getEndereco() + " (Não classificado)";
	}
} // fim da classe Site