package br.com.agendr.rn.entidades;

import br.com.agendr.td.ContatoTipoDT;

public class ContatoTipo extends Tipo {
	
	public static ContatoTipo[] getTipos(int codigoContato)
		throws Exception
	{
		return ContatoTipoDT.getTipos(codigoContato);
	}

	public void atualizar() {
		// TODO Implementar método atualizar

	}

	public void excluir() {
		// TODO Implementar método excluir

	}

	public void novo() {
		// TODO Implementar método novo

	}

}
