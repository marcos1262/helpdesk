package dao;

import model.Usuario;

import java.util.List;

public class DAOUsuario {
    public List<Usuario> consulta(int inicio, int limite) {
        // TODO consultar no BD
        return null;
    }

    public Usuario consulta(Usuario usuario) {
        // TODO consultar no BD
        return new Usuario("Marcos", usuario.getUsuario(), "123456", "ADMIN");
    }

}
