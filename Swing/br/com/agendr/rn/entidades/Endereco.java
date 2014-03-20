package br.com.agendr.rn.entidades;

public class Endereco extends Entidade {
	
	private String rua = "";
	private String complemento = "";
	private String bairro = "";
	private String cep = "";
	private String cidade = "";
	private String estado = "";
	private String pais = "";
	
	public String getBairro() {
		return bairro;
	}
	public void setBairro(String bairro) {
		this.bairro = bairro;
	}
	public String getCep() {
		return cep;
	}
	public void setCep(String cep) {
		this.cep = cep;
	}
	public String getCidade() {
		return cidade;
	}
	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	public String getComplemento() {
		return complemento;
	}
	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getPais() {
		return pais;
	}
	public void setPais(String pais) {
		this.pais = pais;
	}
	public String getRua() {
		return rua;
	}
	public void setRua(String rua) {
		this.rua = rua;
	}
	
	public String toString()
	{
		return String.format(
				"Rua: %s\n, "+
				"Complemento: %s\n, "+
				"Bairro: %s\n, "+
				"CEP: %s\n, "+
				"Cidade: %s\n, "+
				"Estado: %s\n, "+
				"País: %s (Não Classificado) ",
				getRua(),
				getComplemento(),
				getBairro(),
				getCep(),
				getCidade(),
				getEstado(),
				getPais()
		); // fim da chamado do meod format
	} // fim do método toString
} // fim da clase Endereco