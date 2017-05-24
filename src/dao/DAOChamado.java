package dao;

import dao.bd.ConnectionFactory;
import model.Chamado;
import model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.util.ArrayList;
import java.util.List;

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
                else sql += "true ";
                if (!chamado.getTitulo().equals(""))
                    sql += "AND titulo='" + chamado.getTitulo() + "' ";
                else sql += "AND true ";
                if (chamado.getPrioridade() != null)
                    sql += "AND prioridade='" + chamado.getPrioridade() + "' ";
                else sql += "AND true ";
                if (chamado.getStatus() != null)
                    sql += "AND status='" + chamado.getStatus() + "' ";
                else sql += "AND true ";
                if (chamado.getData() != null)
                    sql += "AND data='" + dataHoraMysql(chamado.getData()) + "' ";
                else sql += "AND true ";
                if (chamado.getSolicitante() != null)
                    sql += "AND usuario_idsolicitante='" + chamado.getSolicitante().getId() + "' ";
                else sql += "AND true ";
                if (chamado.getTecnico() != null)
                    sql += "AND usuario_idtecnico='" + chamado.getTecnico().getId() + "' ";
                else sql += "AND true ";

                sql += "LIMIT " + inicio + ", " + qtd;

                PreparedStatement ps = conexao.prepareStatement(sql);
                {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        Chamado c = new Chamado();
                        {
                            c.setId(rs.getLong("idchamado"));
                            c.setTitulo(rs.getString("titulo"));
                            c.setPrioridade(rs.getString("prioridade"));
                            c.setStatus(rs.getString("status"));
                            c.setData(dataHoraJava(rs.getString("tipo")));
                            c.setSolicitante(new Usuario(Long.parseLong(rs.getString("usuario_idsolicitante"))));
                            c.setTecnico(new Usuario(Long.parseLong(rs.getString("usuario_idtecnico"))));
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
                PreparedStatement ps = conexao.prepareStatement(sql);
                ps.setString(1, chamado.getTitulo());
                ps.setString(2, chamado.getPrioridade().toString());
                ps.setString(3, Chamado.statusOpcoes.ABERTO.toString());
                ps.setString(4, dataHoraMysql(LocalDateTime.now()));
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

    /**
     * Atualiza chamado.
     * @param chamado objeto que definirá os atributos e valores a serem alterados
     * @return Verdadeiro caso seja atualizado com sucesso ou Falso caso contrário
     */
    public boolean atualiza(Chamado chamado) {
        return false;
    }

    private String dataHoraMysql(LocalDateTime dataHora) {
        DateTimeFormatter formatador =
                DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
        return dataHora.format(formatador);
    }

    private LocalDateTime dataHoraJava(String dataHora) {
        DateTimeFormatter fmt = new DateTimeFormatterBuilder()
                .appendPattern("yyyy-MM-dd")
                .appendPattern(" hh:mm:ss")
                .toFormatter();
        return LocalDateTime.parse(dataHora, fmt);
    }
}
