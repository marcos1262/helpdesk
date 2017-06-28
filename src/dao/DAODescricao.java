package dao;

import dao.bd.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;

import model.Chamado;
import model.Facade;

public class DAODescricao {
    private Connection conexao;

    //o método está preparado para gravar apenas uma descrição que venha inclusa no objeto chamado.
    boolean cadastraDescricao(Chamado chamado) {
        try {
            this.conexao = new ConnectionFactory().getConnection();
            String sql = "INSERT INTO descricao (descricao, chamado_idchamado, usuario_idautor, data) VALUES (?,?,?,?)";
            PreparedStatement ps = conexao.prepareStatement(sql);
            {
                ps.setString(1, chamado.getDescricoes().get(0).getDescricao());
                ps.setLong(2, chamado.getId());
                ps.setLong(3, chamado.getDescricoes().get(0).getId());
                ps.setString(4, new Facade().dataHoraMysql(LocalDateTime.now()));
                ps.execute();
            }
            ps.close();
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return true;
    }

    boolean atualizaDescricoes(Chamado chamado) {
        boolean executou = true;
        //todo atualiza descrições
        return executou;
    }
}
