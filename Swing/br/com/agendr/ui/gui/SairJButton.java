package br.com.agendr.ui.gui;

import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JButton;

public class SairJButton extends JButton {
	public static final long serialVersionUID = 1;
	
	public SairJButton()
	{			
		super("Sair");
		Icon icon = new ImageIcon(getClass().getResource("sair16.png"));
		
		super.setIcon(icon);
		
		setMnemonic('r');
	}
}
