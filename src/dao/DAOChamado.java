package dao;

import dao.bd.ConnectionFactory;
import model.Chamado;
import model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Descricao;

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
     * @param chamado objeto que definirá os parâmetros da busca
     * @param inicio  número de registro inicial
     * @param qtd     quantidades de registros
     * @return Lista de chamados começando em [inicio] com [qtd] itens ou NULL quando não há resultados
     */
    public List<Chamado> consulta(Chamado chamado, int inicio, int qtd) {
        ArrayList<Chamado> l = new ArrayList<>();
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "SELECT * FROM chamado WHERE ";

                if (chamado.getId() != 0)
                    sql += "idchamado='" + chamado.getId() + "' ";
                else sql += "TRUE ";
                if (!chamado.getTitulo().equals(""))
                    sql += "AND titulo LIKE '%" + chamado.getTitulo() + "%' ";
                if (chamado.getPrioridade() != null)
                    sql += "AND prioridade='" + chamado.getPrioridade() + "' ";
                if (chamado.getStatus() != null)
                    sql += "AND status='" + chamado.getStatus() + "' ";
                if (chamado.getData() != null)
                    sql += "AND data='" + dataHoraMysql(chamado.getData()) + "' ";
                if (chamado.getSolicitante() != null)
                    sql += "AND usuario_idsolicitante='" + chamado.getSolicitante().getId() + "' ";
                if (chamado.getTecnico() != null)
                    sql += "AND usuario_idtecnico='" + chamado.getTecnico().getId() + "' ";

                sql += "LIMIT " + inicio + ", " + qtd;
                PreparedStatement ps = conexao.prepareStatement(sql);
                {
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        Chamado c = new Chamado();
                        {
                            c.setId(rs.getLong("idchamado"));
                            c.setTitulo(rs.getString("titulo"));
                            c.setPrioridade(rs.getString("prioridade"));
                            c.setStatus(rs.getString("status"));
                            c.setData(dataHoraJava(rs.getString("data")));
                            c.setSolicitante(new Usuario(rs.getLong("usuario_idsolicitante")));
                            c.setTecnico(new Usuario(rs.getLong("usuario_idtecnico")));
                            // TODO consultar descrições
                        }
                        l.add(c);
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
    public boolean cadastra(Chamado chamado) {
        boolean executou;
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "INSERT INTO chamado " +
                        "(titulo, prioridade, status, data, usuario_idsolicitante) " +
                        "VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, chamado.getTitulo());
                ps.setString(2, chamado.getPrioridade().toString());
                ps.setString(3, Chamado.statusOpcoes.ABERTO.toString());
                ps.setString(4, dataHoraMysql(LocalDateTime.now()));
                ps.setString(5, String.valueOf(chamado.getSolicitante().getId()));
                executou = ps.execute();
                final ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    //Gravando Descricao
                    chamado.setId(rs.getInt("idchamado"));
                    new DAODescricao().cadastraDescricao(chamado);
                }
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return executou;
    }

    /**
     * Atualiza chamado.
     *
     * @param chamado objeto que definirá os atributos e valores a serem alterados
     * @return Verdadeiro caso seja atualizado com sucesso ou Falso caso contrário
     */
    public boolean atualiza(Chamado chamado) {
        boolean executou = false;
        try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "UPDATE chamado set " +
                        "prioridade = ?, status = ?, usuario_idtecnico = ?" +
                        "WHERE idchamado = ?";
                PreparedStatement ps = conexao.prepareStatement(sql);
                {
                    ps.setLong(1, chamado.getId());
                    ps.setLong(2, chamado.getId());

                    if (ps.execute()) {
                        //Atualizando Descricões
                        if (new DAODescricao().atualizaDescricões(chamado)) {
                            executou = true;
                        } else {
                            exclui(chamado);
                        }
                    }
                }
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return executou;
    }

    public boolean exclui(Chamado chamado) {
        boolean executou = false;
           try {
            this.conexao = new ConnectionFactory().getConnection();
            {
                String sql = "DELETE FROM chamado " +
                        "WHERE idchamado = ?";
                PreparedStatement ps = conexao.prepareStatement(sql);
                ps.setLong(1, chamado.getId());
                executou = ps.execute();
                ps.close();
            }
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return executou;
    }

    private String dataHoraMysql(LocalDateTime dataHora) {
        DateTimeFormatter formatador =
                DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
        return dataHora.format(formatador);
    }

    private LocalDateTime dataHoraJava(String dataHora) {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
        return LocalDateTime.parse(dataHora, fmt);
    } 

    public boolean addDescricao(long idchamado, Descricao descrição) {
        return new DAODescricao().cadastraDescricao(new Chamado(idchamado,descrição));
    }
}
