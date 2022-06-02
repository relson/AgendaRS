package br.com.agendr.ui.gui;

import java.awt.AWTException;
import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.GridLayout;
import java.awt.HeadlessException;
import java.awt.Image;
import java.awt.TrayIcon;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.awt.SystemTray;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

import javax.swing.WindowConstants;

import javax.swing.border.TitledBorder;

public class Main extends JFrame implements WindowListener{
	
	private Container conteiner;
	
	public JPanel centralJPanel = new JPanel();
	public JPanel esquerdoJPanel = new JPanel();
	
	private MainMenuBar menuBar = new MainMenuBar(); 
	
	private JButton resumoJButton = new JButton("Resumo");
	private JButton contatoJButton = new JButton("Contato");
	private JButton tarefaJButton = new JButton("Tarefa");
	private JButton calendarioJButton = new JButton("Calendário");
	private JButton rssJButton = new JButton("RSS");
	private JButton anotacoesJButton = new JButton("Anotações");;
	
	private BotoesActionListener botoesActionListener = new BotoesActionListener(); 
	
	private SystemTray tray;
	private TrayIcon trayIcon;
	
	private static final long  serialVersionUID = 1;
	
	public void windowActivated(WindowEvent e) {		 
		this.repaint();		
		if (trayIcon!=null)
		{
			tray.remove(trayIcon);
			trayIcon = null;
		}
	}

	public void windowClosed(WindowEvent e) {
		
	}

	public void windowClosing(WindowEvent e) {
		toSysTray();		
	}

	public void windowDeactivated(WindowEvent e) {
		
	}

	public void windowDeiconified(WindowEvent e) {
		
	}

	public void windowIconified(WindowEvent e) {
		
	}

	public void windowOpened(WindowEvent e) {
		
	}

	public Main() throws HeadlessException {		
		this("Agendr Beta 1");
	}
	
	public Main(String title) throws HeadlessException {
		super(title);		
		setJMenuBar(menuBar);
		
		centralJPanel = new ResumoJPanel();
		add(centralJPanel);
		
		/*
		 *  Configura os Event Listener dos botões
		 * do painel esquerdo
		 * 
		 */
		
		setLayout(new BorderLayout(5,5));
		contatoJButton.addActionListener(botoesActionListener);
		tarefaJButton.addActionListener(botoesActionListener);
		calendarioJButton.addActionListener(botoesActionListener);
		rssJButton.addActionListener(botoesActionListener);
		resumoJButton.addActionListener(botoesActionListener);
		anotacoesJButton.addActionListener(botoesActionListener);
		
		add(centralJPanel, BorderLayout.CENTER);
		
		esquerdoJPanel.setLayout(new GridLayout(6, 1, 10, 5));
		esquerdoJPanel.add(contatoJButton);
		esquerdoJPanel.add(tarefaJButton);
		esquerdoJPanel.add(calendarioJButton);		
		esquerdoJPanel.add(anotacoesJButton);
		esquerdoJPanel.add(rssJButton);
		esquerdoJPanel.add(resumoJButton);
		esquerdoJPanel.setBorder(new TitledBorder(" "));
		add(esquerdoJPanel, BorderLayout.WEST);
		
		tray = SystemTray.getSystemTray();
		
		setIconesJButton();
		
	}	// fim do Método main
	
	private void setIconesJButton()
	{		
		contatoJButton.setIcon(new ImageIcon(getClass().getResource("contato32.png")));
		tarefaJButton.setIcon(new ImageIcon(getClass().getResource("tarefa32.png")));
		calendarioJButton.setIcon(new ImageIcon(getClass().getResource("calendario32.png")));
		anotacoesJButton.setIcon(new ImageIcon(getClass().getResource("anotacoes32.png")));
		rssJButton.setIcon(new ImageIcon(getClass().getResource("rss32.png")));
		resumoJButton.setIcon(new ImageIcon(getClass().getResource("resumo32.png")));
		setIconImage(new ImageIcon(getClass().getResource("agendr16.png")).getImage());
	}
	
	public void toSysTray()
	{
		
		try
		{			
			if (trayIcon == null){
				Image imageIcon = new ImageIcon(getClass().getResource("agendr16.png")).getImage();
				trayIcon = new TrayIcon(imageIcon,"Agendr Beta 1", new SysTrayPopupMenu(this));
				tray.add(trayIcon);
			}
			
			this.setVisible(false);
		}
		catch(AWTException e)
		{
			JOptionPane.showMessageDialog(this,"Erro ao tentar colocar o ícone na badeja","Error",JOptionPane.ERROR_MESSAGE);
			System.exit(0);
		}
	} // fim do método toSysTray
	
	public static void main(String args[]){		
		
		Main app = new Main("agendR Beta 1");
			
		app.addWindowListener(app);
		
		app.setSize(640,480);
		app.setDefaultCloseOperation(WindowConstants.HIDE_ON_CLOSE);
		app.repaint();
		app.conteiner = app.getContentPane();
		app.setVisible(true);
	} // fim do método Main
	
	
	/** 
	 * Classe responsável por delegar qual painel ser? exibido
	 * ao clicar num dos botões da lateral esquerdada na janela principal.
	 * 
	 * @author Sebastião Relson 10/06/2007
	 *
	 */
	private class BotoesActionListener implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			
			Object jbutton = e.getSource();
			
			JPanel jpanel;
			
			if (jbutton == contatoJButton)
			{				
				jpanel= new ContatoJPanel();
							
			} else if (jbutton == tarefaJButton) {
				jpanel = new TarefaJPanel();
			} else if (jbutton == calendarioJButton) {
				jpanel = new CalendarioJPanel();
				
			} else if (jbutton == resumoJButton) {
				jpanel = new ResumoJPanel();
			} else if (jbutton == rssJButton) {
				jpanel = new RssJPanel();
			} else if (jbutton == anotacoesJButton) {
				jpanel = new AnotacaoJPanel();			
			} else {
				jpanel = new JPanel();
			}
			
			remove(centralJPanel);			
			centralJPanel = jpanel;
			add(centralJPanel,  BorderLayout.CENTER);
			conteiner.validate();
		} // fim do método actionPerformed		
	} // fim da classe interna BotoesActionListener
} // fim da classse Main
