package br.com.agendr.rn.entidades;

public class Email extends Entidade{
	
	private String endereco;

	public String getEndereco() {
		return endereco;
	}

	public void setEndereco(String endereco) {
		this.endereco = endereco;
	} // fim do método setEndereco
	
	public String toString()
	{
		return getEndereco() + "(Não Classificado)";
	}
} // fim da classe Email
