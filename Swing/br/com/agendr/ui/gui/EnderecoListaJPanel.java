package br.com.agendr.ui.gui;

import br.com.agendr.rn.entidades.Contato;

public class EnderecoListaJPanel extends EntidadeListaJPanel {
	
	public static final long serialVersionUID = 1;
	
	private EnderecoListaJPanel() {

	}

	public EnderecoListaJPanel(Contato contato) 
		throws Exception
	{
		// TODO Documentar construtor.
		super();
		try
		{
			super.jList.setListData(contato.getEnderecos());
		} // fim do try
		catch (Exception exception)
		{
			throw exception;
		} // fim do catch
	} // fim do construtor com um argumento
} // fim da classe