package br.com.agendr.ui.gui;

import java.awt.MenuItem;
import java.awt.PopupMenu;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class SysTrayPopupMenu extends PopupMenu{
	
	public static final long serialVersionUID = 1;
	
	private Main mainJFrame = new Main();
	
	public void setMainJframe(Main mainJFrame)
	{
		this.mainJFrame = mainJFrame;
	}
	
	public SysTrayPopupMenu(Main mainFrame) {
		this();
		setMainJframe(mainFrame);
	}
	
	public SysTrayPopupMenu() {
		super();
		
		MenuItem abrirMenuItem = new MenuItem("Abrir");
		abrirMenuItem.addActionListener(new AbrirActionListener());
		
		add(abrirMenuItem);
		
		addSeparator();
		
		MenuItem sairMenuItem = new MenuItem("Sair");
		sairMenuItem.addActionListener(new SairActionListener());
		
		add(sairMenuItem);
		
		
	}
	
	private class AbrirActionListener implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			mainJFrame.setVisible(true);		
		} // fim do método actionPerformed
	} // fim da classe interna privada AbrirActionListener
} // fim da classe SysTrayPopupMenu
