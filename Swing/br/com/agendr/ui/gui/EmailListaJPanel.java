package br.com.agendr.ui.gui;

import br.com.agendr.rn.entidades.Contato;

public class EmailListaJPanel extends EntidadeListaJPanel 
{
	public static final long serialVersionUID = 1;
	
	/**
	 * Documentar método
	 *
	 */
	private EmailListaJPanel() {
		// TODO Documentar construtor.
	}
	
	public EmailListaJPanel(Contato contato) throws Exception
	{
		// TODO Documentar construtor.
		super();
		try
		{
			super.jList.setListData(contato.getEmails());
		} // fim do try
		catch (Exception exception)
		{
			throw exception;
		} // fim do catch
	} // fim do construtor com um argumento
} // fim da classe EmailListJPanel