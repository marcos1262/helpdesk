package dao;

import dao.bd.ConnectionFactory;
import model.Usuario;

import java.sql.*;
import java.util.ArrayList;
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
    public List<Usuario> consulta(Usuario usuario, int inicio, int qtd) {
        ArrayList<Usuario> l = new ArrayList<>();
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "SELECT * " +
                        "FROM usuario " +
                        "WHERE ";

                if (usuario.getId() != 0)
                    sql += "idusuario='" + usuario.getId() + "' ";
                else sql += "TRUE ";
                if (usuario.getNome() != null)
                    sql += "AND nome LIKE '%" + usuario.getNome() + "%' ";
                if (usuario.getUsuario() != null)
                    sql += "AND login = '" + usuario.getUsuario() + "' ";
                if (usuario.getTipo() != null)
                    sql += "AND tipo = '" + usuario.getTipo() + "' ";
                if (usuario.isAtivo() != null)
                    sql += "AND ativo = '" + usuario.isAtivo() + "' ";

                sql += "ORDER BY idusuario LIMIT " + inicio + ", " + qtd;
                PreparedStatement ps = conexao.prepareStatement(sql);
                {
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        Usuario u = new Usuario();
                        {
                            u.setId(rs.getLong("idusuario"));
                            u.setNome(rs.getString("nome"));
                            u.setUsuario(rs.getString("login"));
                            u.setSenha(rs.getString("senha"));
                            u.setTipo(rs.getString("tipo"));
                            u.setAtivo(rs.getBoolean("ativo"));
                        }
                        l.add(u);
                    }
                    rs.close();
                }
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return l;
    }

    /**
     * Consulta um usuário pelos atributos não nulos do objeto
     *
     * @param usuario objeto com parâmetros de consulta
     * @return Usuário com os dados consultados ou NULL quando não há resultados
     */
    public Usuario consulta(Usuario usuario) {
        Usuario usuario1 = new Usuario();

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
                        usuario1.setImagem(rs.getString("imagem"));
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
    
    /**
     * Consulta um usuário pelo tipo
     *
     * @param tipo id do usuário a ser retornado
     * @return Usuário com os dados consultados ou NULL quando não há resultados
     */
    public List<Usuario> consultaTipo(String tipo) {
        Usuario usuario1 = new Usuario();
        List<Usuario> usuarios = new ArrayList<>();

        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "SELECT * FROM usuario WHERE tipo=?";
                PreparedStatement ps = conexao.prepareStatement(sql);
                ps.setString(1, tipo);
                {
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        usuario1.setId(rs.getLong("idusuario"));
                        usuario1.setNome(rs.getString("nome"));
                        usuario1.setUsuario(rs.getString("login"));
                        usuario1.setSenha(rs.getString("senha"));
                        usuario1.setTipo(rs.getString("tipo"));
                        usuario1.setImagem(rs.getString("imagem"));
                        usuarios.add(usuario1);
                    }
                    rs.close();
                }
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return usuarios;
    }

    public boolean cadastra(Usuario usuario) {
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "INSERT INTO usuario " +
                        "(nome, login, senha, tipo, imagem) " +
                        "VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conexao.prepareStatement(sql);
                ps.setString(1, usuario.getNome());
                ps.setString(2, usuario.getUsuario());
                ps.setString(3, usuario.getSenha());
                ps.setString(4, usuario.getTipo().toString());
                ps.setString(5, usuario.getImagem());
                ps.execute();
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return true;
    }

    public boolean atualiza(Usuario usuario) {
        boolean executou = false;
        //todo atualiza
        return executou;
    }

    public boolean exclui(long idusuario) {
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "DELETE FROM usuario " +
                        "WHERE idusuario = ?";
                PreparedStatement ps = conexao.prepareStatement(sql);
                ps.setLong(1, idusuario);
                ps.execute();
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return true;
    }

}
