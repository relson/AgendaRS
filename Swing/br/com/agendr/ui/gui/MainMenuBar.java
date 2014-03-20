package br.com.agendr.ui.gui;

import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.ImageIcon;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;

import br.com.agendr.td.EntidadeDT;


public class MainMenuBar extends JMenuBar {
	
	public static final long serialVersionUID = 1;
	
	public JMenu arquivoMenu;
	
	public JMenuItem sairMenuItem;
	
	public JMenu editarMenu;
	
	private JMenu mnuTipo;
	
	public JMenuItem tipoEditarMenuItem[];
	
	
	public MainMenuBar() throws HeadlessException {
		
		super();
		
		configurarArquivoMenu();
		arquivoMenu.setMnemonic('A');
		add(arquivoMenu);
		
		configurarEditarMenu();
		editarMenu.setMnemonic('E');
		add(editarMenu);
	} // fim do construtor sem argumentos
	
	/**
	 * Configura o menu e sub menus do menu Arquivo
	 * @author Sebastião Relson
	 */
	private void configurarArquivoMenu() {
		
		ImageIcon sairIcon = new ImageIcon(getClass().getResource("sair16.png"));
		
		sairMenuItem = new JMenuItem("Sair", sairIcon);
		
		sairMenuItem.setMnemonic('S');
		
		sairMenuItem.addActionListener(new SairActionListener());
		
		arquivoMenu = new JMenu("Arquivo");
		
		arquivoMenu.add(new JMenuItem("Contatos", new ImageIcon(getClass().getResource("contato16.png"))));
		arquivoMenu.add(new JMenuItem("Tarefas", new ImageIcon(getClass().getResource("tarefa16.png"))));
		arquivoMenu.add(new JMenuItem("Calendário", new ImageIcon(getClass().getResource("calendario16.png"))));
		arquivoMenu.add(new JMenuItem("Anotações", new ImageIcon(getClass().getResource("anotacoes16.png"))));
		arquivoMenu.add(new JMenuItem("RSS", new ImageIcon(getClass().getResource("rss16.png"))));
		
		arquivoMenu.addSeparator();
		
		arquivoMenu.add(sairMenuItem);
		
		
				
		
	} // fim do método configurarArquivoMenu
	
	/**
	 * Configura o menu e sub menus do menu Arquivo
	 */
	private void configurarEditarMenu() {
		
		editarMenu = new JMenu("Editar");
		
		String[] nomes = EntidadeDT.getNomeEntidades();
		
		tipoEditarMenuItem = new JMenuItem[nomes.length];
		
		mnuTipo = new JMenu("Tipos");
		
		ActionListener listener = new TipoEditarMenuItemActionListener();
		
		for (int i = 0; i < nomes.length; ++i)
		{
			tipoEditarMenuItem[i] = new JMenuItem(nomes[i]);
			tipoEditarMenuItem[i].addActionListener(listener);
			mnuTipo.add(tipoEditarMenuItem[i]);
		} // fim do for
		
		editarMenu.add(mnuTipo);
		
		editarMenu.addSeparator();
		
		editarMenu.add(new JMenuItem("Preferências"));
	} // fim do método 
	
	/**
	 * ActionListener para os menuItem de edição de Tipos
	 */
	private class TipoEditarMenuItemActionListener implements ActionListener{
		public void actionPerformed(ActionEvent event) {
			for(int i = 0; i < tipoEditarMenuItem.length; ++i)
			{
				if (event.getSource() == tipoEditarMenuItem[i])
				{
					String nome = EntidadeDT.getNomeEntidades()[i];
					new TipoJFrame(nome);					
				}
			} // fim do for
		} // fim do métod actionPerformed
	} // fim da classe TipoEditarMenuItemActionListener
	
} // fim da classe
