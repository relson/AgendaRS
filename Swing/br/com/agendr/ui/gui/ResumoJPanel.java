package br.com.agendr.ui.gui;

import java.awt.Font;

import javax.swing.JLabel;
import javax.swing.JPanel;

public class ResumoJPanel extends JPanel {
	
	private static final long  serialVersionUID = 1;

	public ResumoJPanel() {
		super();
		// TODO Contrutor do Painel Resumo
		JLabel jlabel = new JLabel("Resumo");
		
		jlabel.setFont(new Font("Arial",Font.BOLD + Font.ITALIC,22));
		
		add(jlabel);
	}

}
