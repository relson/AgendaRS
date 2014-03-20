package br.com.agendr.ui.gui;

import javax.swing.JButton;
import javax.swing.ImageIcon;
import javax.swing.Icon;

public class AplicarJButton extends JButton{
	
	public static final long serialVersionUID = 1;
	
	public AplicarJButton()
	{			
		super("Aplicar");
		Icon icon = new ImageIcon(getClass().getResource("aplicar16.png"));
		
		super.setIcon(icon);
		
		setMnemonic('A');
	}
}
