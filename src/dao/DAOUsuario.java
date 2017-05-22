package dao;

import dao.bd.ConnectionFactory;
import model.Usuario;
import java.sql.*;
import java.util.List;

/**
 * Classe de acesso aos dados de um usuário (@see {@link Usuario}) no Banco de Dados
 *
 * @author marcos
 */
public class DAOUsuario {

    private Connection conexao;

    /**
     * Consulta fatia de todos os usuários (ideal para paginação)
     *
     * @param inicio número de tupla inicial
     * @param qtd    quantidades de tuplas
     * @return Lista de usuários começando em [inicio] com [qtd] itens ou NULL quando não há resultados
     */
    public List<Usuario> consulta(int inicio, int qtd) {
        // TODO consultar no BD
        return null;
    }

    /**
     * Consulta um usuário pelos atributos não nulos do objeto
     *
     * @param usuario objeto com parâmetros de consulta
     * @return Usuário com os dados consultados ou NULL quando não há resultados
     */
    public Usuario consulta(Usuario usuario) {
        Usuario usuario1 = new Usuario("","","", null);

        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "SELECT * FROM usuario WHERE login=?";
                PreparedStatement ps = conexao.prepareStatement(sql);
                ps.setString(1, usuario.getUsuario());
                {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        usuario1.setId(rs.getLong("idusuario"));
                        usuario1.setNome(rs.getString("nome"));
                        usuario1.setUsuario(rs.getString("login"));
                        usuario1.setSenha(rs.getString("senha"));
                        usuario1.setTipo(rs.getString("tipo"));
                    }
                    rs.close();
                }
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (usuario.validaSenha(usuario1))
            return usuario1;
        else return null;
    }

}
