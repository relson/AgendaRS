package br.com.agendr.ad;

import java.sql.SQLException;

import javax.sql.rowset.CachedRowSet;
import javax.sql.rowset.RowSetProvider;

public class DbConnect {

	public static CachedRowSet dbConnect(String dbType, String dbName, String url, String user, String password)
			throws SQLException, ClassNotFoundException, InstantiationException,
			IllegalAccessException {

		String dbase = "";

		CachedRowSet rowSet = RowSetProvider.newFactory().createCachedRowSet();

		if (dbType.equalsIgnoreCase("mysql")) {

			dbase = "jdbc:mysql://" + url + "/" + dbName;
			Class.forName("com.mysql.jdbc.Driver").newInstance();

		} else if (dbType.equalsIgnoreCase("postgresql")) {

			dbase = "jdbc:postgresql://" + url + "/" + dbName;

		} else {
			throw new InstantiationException("Banco nao especificado corretamente");
		}

		rowSet.setUrl(dbase);
		rowSet.setUsername(user);
		rowSet.setPassword(password);

		return rowSet;
	}

	// Metodo que conecta ao banco local mySql
	public static CachedRowSet mysqlConnect() throws SQLException, ClassNotFoundException,
			InstantiationException, IllegalAccessException {

		CachedRowSet rowSet = RowSetProvider.newFactory().createCachedRowSet();

		Class.forName("com.mysql.jdbc.Driver").newInstance();
		rowSet.setUrl("jdbc:mysql://localhost/agendr");
		rowSet.setUsername("root");
		rowSet.setPassword("secreto");

		return rowSet;
	}

	// Metodo que conecta ao banco local PostgreSql
	public static CachedRowSet postgresqlConnect() throws SQLException, ClassNotFoundException,
			InstantiationException, IllegalAccessException {

		CachedRowSet rowSet = RowSetProvider.newFactory().createCachedRowSet();

		Class.forName("org.postgresql.Driver").newInstance();
		rowSet.setUrl("jdbc:postgresql://localhost/agendr");
		rowSet.setUsername("root");
		rowSet.setPassword("secreto");
		return rowSet;
	}

}
