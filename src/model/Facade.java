package model;

import dao.DAOChamado;
import dao.DAOUsuario;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Interface entre visão da aplicação e implementação das funcionalidades da aplicação
 *
 * @author marcos
 */
public class Facade {
    public Usuario autentica(String login, String senha) {
        DAOUsuario du = new DAOUsuario();
        Usuario usuario = du.consulta(new Usuario(login, md5(senha)));

        //TODO testar retorno de Usuario null
        if (usuario != null)
            return usuario;
        else return null;
    }

    public boolean abreChamado(String titulo, String prioridade, String descricao, long idsolicitante) {
        DAOChamado dc= new DAOChamado();
        Chamado chamado = new Chamado();
        chamado.setTitulo(titulo);
        chamado.setPrioridade(prioridade);
        chamado.setSolicitante(new Usuario(idsolicitante));
        return dc.cadastra(chamado);
    }



    private String md5(String s) {
        try {
            MessageDigest m = MessageDigest.getInstance("MD5");
            m.update(s.getBytes(), 0, s.length());
            return new BigInteger(1, m.digest()).toString(16);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
