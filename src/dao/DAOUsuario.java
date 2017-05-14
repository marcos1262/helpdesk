package dao;

import model.Usuario;
import java.util.List;

/**
 * Classe de acesso aos dados de um usuário (@see {@link Usuario}) no Banco de Dados
 * @author marcos
 */
public class DAOUsuario {

    /**
     * Consulta fatia de todos os usuársuios (ideal para paginação)
     * @param inicio número de tupla inicial
     * @param qtd quantidades de tuplas
     * @return Lista de usuários começando em [inicio] com [qtd] itens ou NULL quando não há resultados
     */
    public List<Usuario> consulta(int inicio, int qtd) {
        // TODO consultar no BD
        return null;
    }

    /**
     * Consulta um usuário pelos atributos não nulos do objeto
     * @param usuario objeto com parâmetros de consulta
     * @return Usuário com os dados consultados ou NULL quando não há resultados
     */
    public Usuario consulta(Usuario usuario) {
        // TODO consultar no BD
        return new Usuario("Marcos", usuario.getUsuario(), "123456", Usuario.tipos.ADMIN);
    }

}
