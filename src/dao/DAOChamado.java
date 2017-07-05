package dao;

import dao.bd.ConnectionFactory;
import model.Chamado;
import model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import model.Descricao;
import model.Facade;

/**
 * Classe de acesso aos dados de um chamado (@see {@link Chamado}) no Banco de Dados
 *
 * @author marcos
 */
public class DAOChamado {

    private Connection conexao;

    /**
     * Consulta fatia de todos os chamados (ideal para paginação),
     * considerando os atributos não nulos de uma instância de {@link Chamado}.
     *
     * @param chamados objeto que definirá os parâmetros da busca
     * @param inicio   número de registro inicial
     * @param qtd      quantidades de registros
     * @return Lista de chamados começando em [inicio] com [qtd] itens ou NULL quando não há resultados
     */
    public List<Chamado> consulta(List<Chamado> chamados, int inicio, int qtd, LocalDate data_inicial, LocalDate data_final) {
        ArrayList<Chamado> l = new ArrayList<>();
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "SELECT idchamado, titulo, prioridade, status, chamado.data as data, " +
                        "iddescricao, descricao, descricao.data as dataDesc, descricao.usuario_idusuario as autorId, " +
                        "u1.idusuario as solicId, u1.nome as solicNome, " +
                        "usuario_idtecnico as tecniId " +
                        "FROM chamado, descricao, usuario u1 " +
                        "WHERE TRUE ";

                if (chamados.size() > 0) {
                    if (chamados.get(0).getId() != 0)
                        sql += "AND idchamado='" + chamados.get(0).getId() + "' ";
                    if (chamados.get(0).getData() != null)
                        sql += "AND chamado.data = '" + new Facade().dataHoraMysql(chamados.get(0).getData()) + "' ";
                    if (chamados.get(0).getSolicitante() != null)
                        sql += "AND usuario_idsolicitante = '" + chamados.get(0).getSolicitante().getId() + "' ";
                    if (chamados.get(0).getTecnico() != null)
                        if (chamados.get(0).getTecnico().getId() == 0)
                            sql += "AND usuario_idtecnico IS NULL ";
                        else
                            sql += "AND usuario_idtecnico = '" + chamados.get(0).getTecnico().getId() + "' ";
                }

                String sqlTitulo = "(FALSE ";
                for (Chamado chamado :
                        chamados) {
                    if (chamado.getTitulo() != null)
                        sqlTitulo += "OR titulo LIKE '%" + chamado.getTitulo() + "%' ";
                }
                sqlTitulo += ") ";
                if (!sqlTitulo.equals("(FALSE ) ")) sql += "AND "+sqlTitulo;

                String sqlPrioridade = "(FALSE ";
                for (Chamado chamado :
                        chamados) {
                    if (chamado.getPrioridade() != null)
                        sqlPrioridade += "OR prioridade = '" + chamado.getPrioridade() + "' ";
                }
                sqlPrioridade += ") ";
                if (!sqlPrioridade.equals("(FALSE ) ")) sql += "AND "+sqlPrioridade;

                String sqlStatus = "(FALSE ";
                for (Chamado chamado :
                        chamados) {
                    if (chamado.getStatus() != null)
                        sqlStatus += "OR status = '" + chamado.getStatus() + "' ";
                }
                sqlStatus += ") ";
                if (!sqlStatus.equals("(FALSE ) ")) sql += "AND "+sqlStatus;

                if (data_inicial != null) {
                    sql += "AND chamado.data >= '" + data_inicial + "' ";
                }
                if (data_final != null) {
                    sql += "AND chamado.data <= '" + data_final + "' ";
                }

                if (sql.endsWith("TRUE ")) return null;

                sql += "AND chamado.idchamado = descricao.chamado_idchamado " +
                        "AND chamado.usuario_idsolicitante = u1.idusuario " +
                        "ORDER BY chamado.data DESC, iddescricao ASC LIMIT " + inicio + ", " + qtd;

                PreparedStatement ps = conexao.prepareStatement(sql);
                {
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        Descricao desc = new Descricao(
                                rs.getLong("iddescricao"),
                                rs.getString("descricao"),
                                new Facade().dataHoraJava(rs.getString("dataDesc")),
                                new Usuario(rs.getLong("autorId"))
                        );

                        if (l.size() > 0 && rs.getLong("idchamado") == l.get(l.size() - 1).getId()) {
                            l.get(l.size() - 1).getDescricoes().add(desc);
                        } else {
                            Chamado c = new Chamado();
                            {
                                c.setId(rs.getLong("idchamado"));
                                c.setTitulo(rs.getString("titulo"));
                                c.setPrioridade(rs.getString("prioridade"));
                                c.setStatus(rs.getString("status"));
                                c.setData(new Facade().dataHoraJava(rs.getString("data")));

                                Usuario solic = new Usuario(
                                        rs.getLong("solicId"),
                                        rs.getString("solicNome")
                                );
                                c.setSolicitante(solic);

                                if (rs.getString("tecniId") != null) {
                                    Usuario tecni = new Usuario(rs.getLong("tecniId"));
                                    c.setTecnico(tecni);
                                }

                                List<Descricao> ld = new ArrayList<>();
                                ld.add(desc);
                                c.setDescricoes(ld);
                            }
                            l.add(c);
                        }
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
     * Cadastra chamado (dados passados por um solicitante).
     *
     * @param chamado objeto com os dados a serem salvos
     * @return Verdadeiro caso seja cadastrado com sucesso ou Falso caso contrário
     */
    public Chamado cadastra(Chamado chamado) {
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "INSERT INTO chamado " +
                        "(titulo, prioridade, status, data, usuario_idsolicitante) " +
                        "VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                {
                    ps.setString(1, chamado.getTitulo());
                    ps.setString(2, chamado.getPrioridade().toString());
                    ps.setString(3, Chamado.statusOpcoes.ABERTO.toString());
                    ps.setString(4, new Facade().dataHoraMysql(LocalDateTime.now()));
                    ps.setLong(5, chamado.getSolicitante().getId());
                    ps.execute();
                    final ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) {
                        //Gravando Descricao
                        chamado.setId(rs.getInt(1));
                        if (! new DAODescricao().cadastraDescricao(chamado)) {
                            exclui(chamado);
                            chamado = null;
                        }
                    }
                }
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return chamado;
    }

    /**
     * Atualiza chamado.
     *
     * @param chamado objeto que definirá os atributos e valores a serem alterados
     * @return Verdadeiro caso seja atualizado com sucesso ou Falso caso contrário
     */
    public boolean atualiza(Chamado chamado) {
        boolean executou = true;
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "UPDATE chamado SET ";

                if (chamado.getPrioridade() != null)
                    sql += "prioridade='" + chamado.getPrioridade() + "', ";
                else
                    sql += "prioridade = prioridade, ";
                if (chamado.getStatus() != null)
                    sql += "status='" + chamado.getStatus() + "', ";
                else
                    sql += "status = status, ";
                if (chamado.getTecnico() != null)
                    if (chamado.getTecnico().getId() == 0)
                        sql += "usuario_idtecnico IS NULL ";
                    else
                        sql += "usuario_idtecnico='" + chamado.getTecnico().getId() + "' ";
                else
                    sql += "usuario_idtecnico = usuario_idtecnico ";

                sql += "WHERE idchamado = '" + chamado.getId() + "'";
                PreparedStatement ps = conexao.prepareStatement(sql);

                ps.execute();

                //Atualizando Descricões
//                TODO atualizar lista de descrições (adicionar, excluir)
//                if (new DAODescricao().atualizaDescricoes(chamado)) {
                if (chamado.getDescricoes() != null)
                    if (!new DAODescricao().cadastraDescricao(chamado))
//                    TODO desfazer update
//                    exclui(chamado);
                        executou = false;

                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return executou;
    }

    public boolean exclui(Chamado chamado) {
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "DELETE FROM chamado " +
                        "WHERE idchamado = ?";
                PreparedStatement ps = conexao.prepareStatement(sql);
                {
                    ps.setLong(1, chamado.getId());
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
