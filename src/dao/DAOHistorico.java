package dao;

import dao.bd.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDateTime;
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
        boolean executou = true;
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "INSERT INTO historico " +
                        "(acao,justificativa,hora,usuario_idusuario1,chamado_idchamado,usuario_idusuario2) " +
                        "VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conexao.prepareStatement(sql);
                {
                    ps.setString(1, historico.getAcao().toString());
                    ps.setString(2, historico.getJustificativa());
                    ps.setString(3, new Facade().dataHoraMysql(LocalDateTime.now()));
                    ps.setLong(4, historico.getUsuario1().getId());
                    
                    if(historico.getChamado() != null)
                        ps.setLong(5, historico.getChamado().getId());
                    else
                        ps.setNull(5, Types.INTEGER);
                    
                    if(historico.getUsuario2() != null)
                        ps.setLong(6, historico.getUsuario2().getId());
                    else
                        ps.setNull(6, Types.INTEGER);
                    
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
