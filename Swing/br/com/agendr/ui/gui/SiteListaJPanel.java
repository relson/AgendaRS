package br.com.agendr.ui.gui;

import br.com.agendr.rn.entidades.Contato;

public class SiteListaJPanel extends EntidadeListaJPanel {
	
	private static final long  serialVersionUID = 1;
	
	private SiteListaJPanel() {

	}
	
	public SiteListaJPanel(Contato contato)
		throws Exception
	{		
		//		 TODO Documentar construtor.
		super();
		try
		{
			super.jList.setListData(contato.getSites());
		} // fim do try
		catch (Exception exception)
		{
			throw exception;
		} // fim do catch
	} // fim do construtor com um argumento

}
