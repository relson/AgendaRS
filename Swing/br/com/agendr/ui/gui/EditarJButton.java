package br.com.agendr.ui.gui;

import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JButton;

public class EditarJButton extends JButton {

	public static final long serialVersionUID = 1;
	
	public EditarJButton()
	{			
		super("Editar");
		Icon icon = new ImageIcon(getClass().getResource("editar16.png"));
		
		super.setIcon(icon);
		
		setMnemonic('E');
	}
}
