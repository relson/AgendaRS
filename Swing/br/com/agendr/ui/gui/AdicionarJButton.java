package br.com.agendr.ui.gui;

import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JButton;

public class AdicionarJButton extends JButton {
	
	public static final long serialVersionUID = 1;
	
	public AdicionarJButton()
	{	
		super("Adicionar");
		Icon icon = new ImageIcon(getClass().getResource("adicionar16.png"));
		
		super.setIcon(icon);
		
		setMnemonic('d');
	}
}