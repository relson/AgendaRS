package br.com.agendr.ui.gui;

import java.awt.Font;

import javax.swing.JLabel;

public class AnotacaoJPanel extends EntidadeListaJPanel{
	
	private static final long  serialVersionUID = 1;
	
	public AnotacaoJPanel() {
		super();
		// TODO Contrutor do Painel Calend�rio
		JLabel jlabel = new JLabel("Anota��es");
		
		jlabel.setFont(new Font("Arial",Font.BOLD + Font.ITALIC,22));
		
		add(jlabel);
	}

}
