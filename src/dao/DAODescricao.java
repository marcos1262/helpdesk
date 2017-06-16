package dao;

import dao.bd.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.Chamado;

public class DAODescricao {
    private Connection conexao;

    //o método está preparado para gravar apenas uma descrição que venha inclusa no objeto chamado.
    protected boolean cadastraDescricao(Chamado chamado) {
        try {
            this.conexao = new ConnectionFactory().getConnection();
            String sql = "INSERT INTO descricao (descricao, chamado_idchamado) VALUES (?,?)";
            PreparedStatement ps = conexao.prepareStatement(sql);
            {
                ps.setString(1, chamado.getDescricoes().get(0).getDescricao());
                ps.setLong(2, chamado.getId());
                ps.execute();
            }
            ps.close();
            conexao.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return true;
    }

    protected boolean atualizaDescricoes(Chamado chamado) {
        boolean executou = false;
        //todo atualiza
        return executou;
    }
}
