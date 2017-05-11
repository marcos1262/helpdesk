package model;

import dao.DAOUsuario;

public class Facade {
    public Usuario autentica (String login, String senha) {
        //TODO autentica
        DAOUsuario du = new DAOUsuario();
        Usuario usuario = new Usuario("", login, "", "");

        //TODO tratar retorno de Usuario null
        if (du.consulta(usuario).getSenha().equals(senha)) {
            return usuario;
        }
        return null;
    }


}
