package dao.bd;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Cria conexões com o Banco de Dados da aplicação
 *
 * @author marcos
 */
public class ConnectionFactory {
    public Connection getConnection() throws SQLException{
        MysqlDataSource dataSource = new MysqlDataSource();
        dataSource.setUser("helpdesk");
        dataSource.setPassword("deskhelp");
        dataSource.setServerName("localhost");
        dataSource.setDatabaseName("helpdesk");
        return dataSource.getConnection();
    }
}
