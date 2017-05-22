package dao;

import dao.bd.ConnectionFactory;
import model.Chamado;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Classe de acesso aos dados de um chamado (@see {@link Chamado}) no Banco de Dados
 *
 * @author marcos
 */
public class DAOChamado {

    private Connection conexao;

    /**
     * Consulta fatia de todos os chamados (ideal para paginação)
     *
     * @param inicio número de tupla inicial
     * @param qtd    quantidades de tuplas
     * @return Lista de chamados começando em [inicio] com [qtd] itens ou NULL quando não há resultados
     */
    public List<Chamado> consulta(int inicio, int qtd) {
        // TODO consultar no BD
        return null;
    }

    /**
     * Consulta um chamado pelos atributos não nulos do objeto
     *
     * @param chamado objeto com parâmetros de consulta
     * @return Chamado com os dados consultados ou NULL quando não há resultados
     */
//    public Usuario consulta(Usuario usuario) {
//        Usuario usuario1 = new Usuario("","","", null);
//
//        try {
//            this.conexao = new ConnectionFactory().getConnection();
//            {
//                String sql = "SELECT * FROM usuario WHERE login=?";
//                PreparedStatement ps = conexao.prepareStatement(sql);
//                ps.setString(1, usuario.getUsuario());
//                {
//                    ResultSet rs = ps.executeQuery();
//                    if (rs.next()) {
//                        usuario1.setNome(rs.getString("nome"));
//                        usuario1.setUsuario(rs.getString("login"));
//                        usuario1.setSenha(rs.getString("senha"));
//                        usuario1.setTipo(rs.getString("tipo"));
//                    }
//                    rs.close();
//                }
//                ps.close();
//            }
//            conexao.close();
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//
//        if (usuario.validaSenha(usuario1))
//            return usuario1;
//        else return null;
//    }
    public boolean cadastra(Chamado chamado) {
        boolean executou;
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "INSERT INTO chamado " +
                        "(titulo, prioridade, status, data, usuario_idsolicitante) " +
                        "VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conexao.prepareStatement(sql);
                ps.setString(1, chamado.getTitulo());
                ps.setString(2, chamado.getPrioridade().toString());
                ps.setString(3, Chamado.statusOpcoes.ABERTO.toString());
                ps.setString(4, dataMysql(LocalDateTime.now()));
                ps.setString(5, String.valueOf(chamado.getSolicitante().getId()));
                System.out.println(chamado);
                executou = ps.execute();
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return executou;
    }

    private String dataMysql(LocalDateTime data) {
        DateTimeFormatter formatador =
                DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return data.format(formatador);
    }
}
