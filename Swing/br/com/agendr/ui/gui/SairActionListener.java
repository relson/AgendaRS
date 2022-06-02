package br.com.agendr.ui.gui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * 
 * Classe que implementa o comportamento padrão para sair
 * Chama a função System.exit(0);
 * 
 * @author Sebastião Relson <sebastiaorelson@systecinfo.com.br>
 * 
 */

public class SairActionListener implements ActionListener {	
	public void actionPerformed(ActionEvent e) {
		System.exit(0);
	}

}
