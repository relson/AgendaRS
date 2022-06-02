package br.com.agendr.ui.gui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.ImageIcon;
import javax.swing.JOptionPane;

import javax.swing.border.TitledBorder;

import br.com.agendr.rn.entidades.Contato;
import br.com.agendr.td.ContatoDT;

public class ContatoJPanel extends EntidadeListaJPanel {
	
	private static final long  serialVersionUID = 1;
	
	public Contato[] listData;
	
	public ContatoJPanel() {
		super();		
		try
		{
			listData = ContatoDT.getContatos();			
			jList.setListData(listData);
		} // fim do try
		catch (Exception exception)
		{
			JOptionPane.showMessageDialog(this, "Erro ao tentar buscar a lista de contatos: \n" + exception.getMessage());
		} // fim do catch
		
		
		adicionarJButton.addActionListener(
			new ActionListener()
			{
				public void actionPerformed(ActionEvent event)
				{
					new ContatoCadastroJFrame();					
				}
			}
		);
		
		editarJButton.addActionListener(
				new ActionListener()
				{
					public void actionPerformed(ActionEvent event)
					{
						Object objects[] = jList.getSelectedValues();
						
						if (objects.length > 0)
							new ContatoCadastroJFrame((Contato)objects[0]);
						else
							JOptionPane.showMessageDialog(
									ContatoJPanel.this, 
									"Nenhum contato selecionado.", 
									"Atenção",
									JOptionPane.WARNING_MESSAGE
								); // fim da chamada do método showMessageDialogo da classe JOptionPane
					}
				}
		);		
		setBorder(new TitledBorder("Contato"));
	}
	
	public ImageIcon getListaIcone()
	{
		return new ImageIcon(getClass().getResource("contato16.png"));
	}
}
