package model;

import dao.DAOChamado;
import dao.DAOUsuario;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

/**
 * Interface entre visão da aplicação e implementação das funcionalidades da aplicação
 *
 * @author marcos
 */
public class Facade {
    //==========================================================================//
    //                              SESSÃO USUÁRIO
    //==========================================================================//
    /**
     * Autentica um usuário (login e senha) no sistema
     * (consulta no Banco de Dados).
     *
     * @param login login do usuário
     * @param senha senha do usuário
     * @return {@link Usuario} com dados consultados ou NULL quando não há resultados
     */
    public Usuario autentica(String login, String senha) {
        DAOUsuario du = new DAOUsuario();
        Usuario usuario = du.consulta(new Usuario(login, md5(senha)));

        //TODO testar retorno de Usuario null
        if (usuario != null)
            return usuario;
        else return null;
    }

    public boolean cadastraUsuario(Usuario usuario) {
         return new DAOUsuario().cadastra(usuario);
    }
    public boolean atualizaUsuario(Usuario usuario) {
        return new DAOUsuario().atualiza(usuario);
    }
    public boolean excluiUsuario(long idusuario) {
        return new DAOUsuario().exclui(idusuario);
    }

    //==========================================================================//
    //                              SESSÃO CHAMADO
    //==========================================================================//
    /**
     * Abre um chamado no sistema
     * (cadastra no Banco de Dados).
     *
     * @param titulo        titulo do chamado
     * @param prioridade    prioridade do chamado
     * @param descricao     descrição do chamado
     * @param idsolicitante id do solicitante ({@link Usuario}) do chamado
     * @return Verdadeiro caso seja aberto com sucesso ou Falso caso contrário
     */
    public boolean abreChamado(String titulo, String prioridade, String descricao, long idsolicitante) {
        Chamado chamado = new Chamado();
        chamado.setTitulo(titulo);
        chamado.setPrioridade(prioridade);
        chamado.setSolicitante(new Usuario(idsolicitante));
//      TODO cadastrar descrição
//      Resolvido -- a descrição inicial "String descrição" vai junto com o objeto "chamado" e é gravado no proprio DAOchamado
        chamado.addDescrição(descricao);
        return new DAOChamado().cadastra(chamado);
    }
   
    /**
     * Exclui um chamado no sistema
     * (Exclui do Banco de Dados).
     *
     * @param idChamado codigo do chamado a ser excluido
     * @return Verdadeiro caso seja excluido com sucesso ou Falso caso contrário
     */
    public boolean excluiChamado(long idChamado) {
        return new DAOChamado().exclui(idChamado);
    }
    /**
     * Consulta fatia de todos os chamados (ideal para paginação),
     * considerando os atributos não nulos de uma instância de {@link Chamado}
     * (consulta no Banco de Dados).
     *
     * @param chamado objeto que definirá os parâmetros da busca
     * @param inicio  número de registro inicial
     * @param qtd     quantidades de registros
     * @return Lista de chamados começando em [inicio] com [qtd] itens ou NULL quando não há resultados
     */
    public List<Chamado> consultaChamados(Chamado chamado, int inicio, int qtd) {
//        TODO testar este método
        return new DAOChamado().consulta(chamado, inicio, qtd);
    }

    /**
     * Atualiza informações de um chamado
     * (atualiza no Banco de Dados).
     *
     * @param chamado objeto que definirá os atributos e valores a serem alterados
     * @return Verdadeiro caso seja atualizado com sucesso ou Falso caso contrário
     */
    public boolean atualizaChamado(Chamado chamado) {
        return new DAOChamado().atualiza(chamado);
    }

    //==========================================================================//
    //                         SESSÃO SERVIÇOS DIVERSOS
    //==========================================================================//
    /**
     * Criptografa texto com MD5
     *
     * @param s texto a ser criptografado
     * @return texto criptografado
     */
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
