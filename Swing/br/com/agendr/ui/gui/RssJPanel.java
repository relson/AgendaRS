package br.com.agendr.ui.gui;

import java.awt.Font;

import javax.swing.JLabel;

public class RssJPanel extends EntidadeListaJPanel{
	
	private static final long  serialVersionUID = 1;
	
	public RssJPanel() {
		super();
		// TODO Contrutor do Painel RSS
		JLabel jlabel = new JLabel("RSS");
		
		jlabel.setFont(new Font("Arial",Font.BOLD + Font.ITALIC,22));
		
		add(jlabel);
	}

}
