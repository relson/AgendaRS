package br.com.agendr.ui.gui;

import java.awt.Font;

import javax.swing.JLabel;
import javax.swing.JPanel;

public class CalendarioJPanel extends JPanel{
	
	private static final long  serialVersionUID = 1;
	
	public CalendarioJPanel() {
		super();
		// TODO Contrutor do Painel Calendário
		JLabel jlabel = new JLabel("Calendário");
		
		jlabel.setFont(new Font("Arial",Font.BOLD + Font.ITALIC,22));
		
		add(jlabel);
	}

}
