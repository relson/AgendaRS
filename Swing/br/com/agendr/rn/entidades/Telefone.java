package br.com.agendr.rn.entidades;

public class Telefone extends Entidade {
	
	private String numero;

	/**
	 * @return um numero de telefone Formatado (XX) XXXX-XXXX
	 */
	public String getNumero() {
		return numero;
	}

	/**
	 * @param numero string contendo o número do telefone
	 */
	public void setNumero(String numero) {
		this.numero = numero;
	} // fim do método setNumero
	
	public String toString()
	{
		return this.numero + " (Não classificado)";
	}
	
} // fim da classe Telefone
