package br.com.agendr.ui.gui;

import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.ListModel;

import br.com.agendr.rn.entidades.Entidade;
import br.com.agendr.rn.entidades.TipoImpl;

/**
 * Classe abstrata para cadastro, implementa vários métodos de conviniencia
 * que será usado em todo o projeto. </p>
 * Configura como padrão um ícone de adição se a entidade configurada for
 * nula e configura o ícone de edição se for passado uma entidade no 
 * construtor, chamando respectivamente os métodos configurarInterfaceAdicao e
 * configurarInterfaceEdicao.<br> </p>
 * 
 * @see configurarInterfaceAdicao
 * @see configurarInterfaceEdicao
 * 
 * @author Sebastião Relson 10/06/2007
 */
public abstract class CadastroJPanel extends JPanel{
	
	public static final long serialVersionUID = 1;
	
	protected Entidade entidade;
		
	/**
	 * Método que configura a interface para a adição, colocando por padrão
	 * o ícone de adição. <br> 
	 */
	public void configurarInterfaceAdicao()
	{
		
	} // fim do método configurarInterfaceAdicao
		
	/**
	 * Método que configura a interface para a adição, colocando por padrão
	 * o ícone de edição. <br> 
	 */
	public void configurarInterfaceEdicao()
	{
		
	} // fim do método configurar
	
	/**
	 * Método que retorna verdadeiro se o Painel estirver em edição.
	 */
	public boolean emEdicao()
	{
		return (entidade != null);
	} // fim do método em edicao
	
	/**
	 *  Configurar o JList os itens selecionados do JList de acordo com o
	 *  vetor de entidades que foi passado.
	 */	
	public void configurarSelecionadosJList(JList jList, Entidade entidades[])
	{
		try
		{
			ListModel listData = jList.getModel();
			
			if (listData == null)
				throw new Exception("Lista não configurada");
			
			int indices[] = new int[entidades.length];
			
			for(int i = 0; i < entidades.length; ++i)
			{
				int codigo = entidades[i].getCodigo();
				for(int j = 0; j < listData.getSize(); ++j)					
				{						
					int codigoLst =  ((TipoImpl)listData.getElementAt(i)).getCodigo();					
					if (codigo == codigoLst)
					{
						indices[i] = j;
						break;
					} // fim do if					
				} // fim do for interno
			} // fim do for externo
			
			jList.setSelectedIndices(indices);
			
		} // fim do try
		catch(Exception exception)
		{
			JOptionPane.showMessageDialog(this,
					"Erro ao tentar configurar os tipos selecionados:\n" 
					+ exception.getMessage(), 
					"Erro", 
					JOptionPane.WARNING_MESSAGE
				); // fim da chamada do métod showMessageDialog do Objeto JOptonPane
		} // fim do catch
		
	} // fim do método configurarTiposSelecionado
} // fim da classe abstrata CadastroJPanel
