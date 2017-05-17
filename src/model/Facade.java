package model;

import dao.DAOUsuario;

/**
 * Interface entre visão da aplicação e implementação das funcionalidades da aplicação
 *
 * @author marcos
 */
public class Facade {
    public Usuario autentica(String login, String senha) {
        //TODO autentica
        DAOUsuario du = new DAOUsuario();
        Usuario usuario = du.consulta(new Usuario(login,senha));

        //TODO testar retorno de Usuario null
        if (usuario != null)
            return usuario;
        else return null;
    }


}
