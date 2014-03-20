package br.com.agendr.ui.gui;

import br.com.agendr.rn.entidades.Contato;

public class TelefoneListaJPanel extends EntidadeListaJPanel {
	
	public static final long serialVersionUID = 1;

	private TelefoneListaJPanel() {
	
	} // fim do contrutor sem argumentos
	
	public TelefoneListaJPanel(Contato contato)
		throws Exception
	{		
		//		 TODO Documentar construtor.
		super();
		try
		{
			super.jList.setListData(contato.getTelefones());
		} // fim do try
		catch (Exception exception)
		{
			throw exception;
		} // fim do catch
	} // fim do construtor com um argumento
} // fim da classe TelefoneListJPanel
