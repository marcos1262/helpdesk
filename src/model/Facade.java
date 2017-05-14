package model;

import dao.DAOUsuario;

public class Facade {
    public Usuario autentica (String login, String senha) {
        //TODO autentica
        DAOUsuario du = new DAOUsuario();
        Usuario usuario = du.consulta(new Usuario(login));

        //TODO testar retorno de Usuario null
        if (usuario!= null && usuario.getSenha().equals(senha)) {
            return usuario;
        }
        return null;
    }


}
