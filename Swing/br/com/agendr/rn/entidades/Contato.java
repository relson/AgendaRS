package br.com.agendr.rn.entidades;

import br.com.agendr.td.ContatoDT;
import br.com.agendr.td.Crud;
import br.com.agendr.td.EmailDT;
import br.com.agendr.td.EnderecoDT;
import br.com.agendr.td.ObservacaoDT;
import br.com.agendr.td.SiteDT;
import br.com.agendr.td.TelefoneDT;

/**
 * Classe contatos
 * @author Sebastião Relson
 * @since domingo, 18 de marco de 2007 
 */
public class Contato extends Entidade implements Crud{
	
	// membros privados da classe
	private String nome;
	private String sobrenome;
	
	private Email emails[];
	private Telefone telefones[];
	private Endereco enderecos[];
	private Site sites[];
	private Observacao observacoes[];
	
	private ContatoTipo contatoTipos[];
	
	public Email[] getEmails() 
		throws Exception  
	{		
		int codigoContato = this.getCodigo();
		
		if (emails == null)
			emails = EmailDT.getEmails(codigoContato);		
		return emails;
	} // fim do método getEmails
	public void setEmails(Email[] emails) {		
		this.emails = emails;
	}
	public Endereco[] getEnderecos()
		throws Exception
	{
		int codigoContato = this.getCodigo();
		
		if (enderecos == null)
			enderecos = EnderecoDT.getEnderecos(codigoContato);
		
		return enderecos;
	}
	public void setEnderecos(Endereco[] enderecos) {
		this.enderecos = enderecos;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public Observacao[] getObservacoes() 
		throws Exception
	{
		
		int codigoContato = this.getCodigo();
		
		if (this.observacoes == null)
			observacoes = ObservacaoDT.getObservacoes(codigoContato);
		
		return observacoes;
	} // fim do método getObsevacoes
	
	public void setObservacoes(Observacao[] observacoes) {
		this.observacoes = observacoes;
	}
	public Site[] getSites()
		throws Exception
	{
		int codigoContato = this.getCodigo();
		
		if (sites == null)
			sites = SiteDT.getSites(codigoContato);
		
		return sites;
	}
	public void setSites(Site[] sites) {
		this.sites = sites;
	}
	public String getSobrenome() {
		return sobrenome;
	}
	public void setSobrenome(String sobrenome) {
		this.sobrenome = sobrenome;
	}
	public Telefone[] getTelefones()
		throws Exception
	{
		int codigoContato = this.getCodigo();		
				
		if (telefones == null)
			telefones = TelefoneDT.getTelefones(codigoContato);		
		
		return telefones;
	}
	public void setTelefones(Telefone[] telefones) {
		this.telefones = telefones;
	}
	
	public ContatoTipo[] getTipos()
		throws Exception
	{		
			
			if (contatoTipos == null)
				setTipos(ContatoTipo.getTipos(this.getCodigo()));
		
			return contatoTipos;	
		
	}
	
	public void setTipos(ContatoTipo[] contatoTipos)
	{
		this.contatoTipos = contatoTipos;
	}
	
	/**
	 * Retorna uma Lista separada por virgula dos Tipos do Contato
	 * 
	 * @author Sebastião Relson
	 */
	public String getListaContatoTipos()
	{
		StringBuffer lista = new StringBuffer();
		
		try
		{
			Tipo[] contatoTipos = this.getTipos();
			
			for(Tipo tipo:contatoTipos)
			{
				lista.append(tipo);
				lista.append(", ");
			}
		} // fim do try
		catch (Exception e)
		{
			return "Contato não Classificado";
		}
		lista.deleteCharAt(lista.length() -2);
		
		return lista.toString().trim();
	}
	
	public String toString()
	{
		return getNome() + " " + getSobrenome() + " (" + getListaContatoTipos() + ")"; 
	}
	
	public void novo() throws Exception{
		ContatoDT.novo(this);		
	} // fim do método novo
	
	public void excluir() {
		// TODO Implementar método Excluir
		
	} // fim do método excluir
	
	public void atualizar() {
		// TODO Implementar método Atualizar
		
	} // fim do método atualizar
} // fim da classe Contato
