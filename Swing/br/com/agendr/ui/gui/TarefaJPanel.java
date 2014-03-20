package br.com.agendr.ui.gui;

import java.awt.Font;
import javax.swing.JLabel;

public class TarefaJPanel extends EntidadeListaJPanel{
	
	private static final long  serialVersionUID = 1;
	
	public TarefaJPanel() {
		super();
		// TODO Contrutor do Painel Tarefas
		JLabel jlabel = new JLabel("Tarefas");
		
		jlabel.setFont(new Font("Arial",Font.BOLD + Font.ITALIC,22));
		
		add(jlabel);
	}

}
