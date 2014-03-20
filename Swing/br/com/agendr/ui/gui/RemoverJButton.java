package br.com.agendr.ui.gui;

import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JButton;

public class RemoverJButton extends JButton {

	public static final long serialVersionUID = 1;
	
	public RemoverJButton()
	{			
		super("Remover");
		Icon icon = new ImageIcon(getClass().getResource("remover16.png"));
		
		super.setIcon(icon);
		
		setMnemonic('R');
	}
}
