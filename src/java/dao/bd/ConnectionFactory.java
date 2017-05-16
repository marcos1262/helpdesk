package java.dao.bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Cria conexões com o Banco de Dados da aplicação
 *
 * @author marcos
 */
public class ConnectionFactory {
    public Connection getConnection() throws SQLException{
            return DriverManager.getConnection("jdbc:mysql://localhost/helpdesk", "helpdesk", "deskhelp");
    }
}
