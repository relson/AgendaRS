package br.com.agendr.ui.gui;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.GridLayout;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.ListCellRenderer;
import javax.swing.border.SoftBevelBorder;
import javax.swing.border.TitledBorder;

public abstract class EntidadeListaJPanel extends JPanel {
	
	// Controles 
	public AdicionarJButton adicionarJButton = new AdicionarJButton();
	public RemoverJButton removerJButton = new RemoverJButton();
	public EditarJButton editarJButton = new EditarJButton();
	
	public JList jList = new JList();
	
	protected final ImageIcon listaIcone = new ImageIcon(getClass().getResource("pergunta16.png"));
    
	public EntidadeListaJPanel() {
		super();
		JPanel topJPanel = new JPanel(new GridLayout(1,3,5,5));
		setLayout(new BorderLayout());
		
		topJPanel.add(adicionarJButton);
		topJPanel.add(removerJButton);
		topJPanel.add(editarJButton);
		
		topJPanel.setBorder(new SoftBevelBorder(5));
		
		add(topJPanel, BorderLayout.NORTH);
		
		JPanel centralJPanel = new JPanel(new BorderLayout());
		centralJPanel.setBorder(new SoftBevelBorder(10));
		jList.setCellRenderer(new MyCellRenderer());
		jList.setBorder(new TitledBorder(""));		
		centralJPanel.add(
				new JScrollPane(
						jList,
						JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED,
						JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED
					), 
					BorderLayout.CENTER);
		add(centralJPanel, BorderLayout.CENTER);
		
	}
	
	//	 Display an icon and a string for each object in the list.
	private class MyCellRenderer extends JLabel implements ListCellRenderer {
	     
	     public static final long serialVersionUID = 1;
	     
	     // This is the only method defined by ListCellRenderer.
	     // We just reconfigure the JLabel each time we're called.

	     public Component getListCellRendererComponent(
	       JList list,              // the list
	       Object value,            // value to display
	       int index,               // cell index
	       boolean isSelected,      // is the cell selected
	       boolean cellHasFocus)    // does the cell have focus
	     {
	         String s = value.toString();
	         setText(s);
	         setIcon(getListaIcone());
	         if (isSelected) {
	             setBackground(list.getSelectionBackground());
	             setForeground(list.getSelectionForeground());
	         } else {
	             setBackground(list.getBackground());	             
	             setForeground(list.getForeground());
	         }
	         setEnabled(list.isEnabled());
	         setFont(list.getFont());
	         setOpaque(true);
	         return this;
	     }
	     
	   
	 }
	 public ImageIcon getListaIcone()
     {
    	 return listaIcone;
     }
}
