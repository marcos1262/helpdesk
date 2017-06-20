package dao;

import dao.bd.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Facade;
import model.Historico;

/**
 *
 * @author Alexandre
 */
public class DAOHistorico {
    private Connection conexao;
    //TODO Consulta
    public List<Historico> consulta(){
         ArrayList<Historico> l = new ArrayList<>();
        try {
            this.conexao = new ConnectionFactory().getConnection();
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return l;
    }
    public boolean cadastra(Historico historico){
        boolean executou = false;
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "INSERT INTO historico " +
                        "(acao,justificativa,hora,usuario1,chamado,usuario2) " +
                        "VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conexao.prepareStatement(sql);
                {
                    ps.setString(1, historico.getAcao());
                    ps.setString(2, historico.getJustificativa());
                    ps.setString(3, new Facade().dataHoraMysql(historico.getHora()));
                    ps.setLong(4, historico.getUsuario1().getId());
                    ps.setLong(5, historico.getChamado().getId());
                    ps.setLong(4, historico.getUsuario2().getId());
                    ps.execute();
                }
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return executou;
    }
    //TODO Atualiza
    public boolean atualiza(Historico historico){
        boolean executou = false;
        try {
            this.conexao = new ConnectionFactory().getConnection();
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return executou;
    }
    
    public boolean exclui(Historico historico){
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "DELETE FROM historico WHERE idhistorico = ?";
                PreparedStatement ps = conexao.prepareStatement(sql);
                {
                    ps.setLong(1, historico.getId());
                    ps.execute();
                }
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return true;
    }
}
