package model;

import dao.DAOChamado;
import dao.DAOHistorico;
import dao.DAOUsuario;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import model.Historico.acoes;

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

    /**
     * Cadastra um usuário no sistema
     * (cadastra no Banco de Dados).
     *
     * @param usuario Objeto com dados do usuário
     * @return Verdadeiro caso seja cadastrado com sucesso ou Falso caso contrário
     */
    public boolean cadastraUsuario(Usuario usuario) {
        return new DAOUsuario().cadastra(usuario);
    }

    /**
     * Atualiza informações de um usuário do sistema
     * (atualiza no Banco de Dados).
     *
     * @param usuario Objeto com novos dados do usuário
     * @return Verdadeiro caso seja atualizado com sucesso ou Falso caso contrário
     */
    public boolean atualizaUsuario(Usuario usuario) {
        return new DAOUsuario().atualiza(usuario);
    }

    /**
     * Remove um usuário do sistema
     * (deleta no Banco de Dados).
     *
     * @param idusuario id do usuário
     * @return Verdadeiro caso seja removido com sucesso ou Falso caso contrário
     */
    public boolean excluiUsuario(long idusuario) {
        return new DAOUsuario().exclui(idusuario);
    }

    /**
     * Consulta fatia de todos os usuários (ideal para paginação),
     * considerando os atributos não nulos de uma instância de {@link Usuario}
     * (consulta no Banco de Dados).
     *
     * @param usuario objeto que definirá os parâmetros da busca
     * @param inicio  número de registro inicial
     * @param qtd     quantidades de registros
     * @return Lista de usuários começando em [inicio] com [qtd] itens ou NULL quando não há resultados
     */
    public List<Usuario> consultaUsuarios(Usuario usuario, int inicio, int qtd) {
        return new DAOUsuario().consulta(usuario, inicio, qtd);
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
    public Chamado abreChamado(String titulo, String prioridade, String descricao, long idsolicitante) {
        Chamado chamado = new Chamado();
        chamado.setTitulo(titulo);
        chamado.setPrioridade(prioridade);
        chamado.setSolicitante(new Usuario(idsolicitante));
        chamado.addDescricao(new Descricao(descricao));
        return new DAOChamado().cadastra(chamado);
    }

    /**
     * Cancela um chamado no sistema
     * (Atualiza no Banco de Dados).
     *
     * @param idChamado codigo do chamado a ser excluido
     * @return Verdadeiro caso seja excluido com sucesso ou Falso caso contrário
     */
    public boolean cancelaChamado(long idChamado) {
        Chamado c = new Chamado();
        c.setId(idChamado);
        c.setStatus("FECHADO_CANCELADO");
        return new DAOChamado().atualiza(c);
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
        ArrayList<Chamado> c = new ArrayList<>();
        c.add(chamado);
        return new DAOChamado().consulta(c, inicio, qtd, null, null);
    }

    public List<Chamado> consultaChamados(List<Chamado> chamados, int inicio, int qtd, LocalDate data_inicial, LocalDate data_final) {
        return new DAOChamado().consulta(chamados, inicio, qtd, data_inicial, data_final);
    }

    public boolean assumeChamado(long idChamado, long idTecnico) {
        Chamado c = new Chamado();
        c.setId(idChamado);
        c.setStatus("ATENDENDO");
        c.setTecnico(new Usuario(idTecnico));
        return new DAOChamado().atualiza(c);
    }

    public boolean transfereChamado(long idChamado, long idNovoTecnico) {
        Chamado chamado = new Chamado();
        chamado.setId(idChamado);
        chamado.setTecnico(new Usuario(idNovoTecnico));
        return new DAOChamado().atualiza(chamado);
    }

    public boolean atualizaChamado(Chamado chamado) {
        return new DAOChamado().atualiza(chamado);
    }

    //==========================================================================//
    //                              SESSÃO HISTÓRICO
    //==========================================================================//

    /**
     * Cadastra um Histórico no sistema
     * (cadastra no Banco de Dados).
     *
     * @param acao          ação que desencadeou o cadastro do histórico
     * @param justificativa justificativa para a ação
     * @param usuario1      usuário envolvido na ação
     * @param chamado       chamado alterado na ação
     * @param usuario2      usuário 2 envolvido na ação
     * @return Verdadeiro caso seja cadastrado com sucesso ou Falso caso contrário
     */
    public boolean cadastraHistorico(acoes acao, String justificativa, Usuario usuario1, Chamado chamado, Usuario usuario2) {
        Historico historico = new Historico();
        historico.setAcao(acao);
        historico.setJustificativa(justificativa);
        historico.setUsuario1(usuario1);
        historico.setChamado(chamado);
        historico.setUsuario2(usuario2);
        return new DAOHistorico().cadastra(historico);
    }

    //==========================================================================//
    //                              SESSÃO TÉCNICO
    //==========================================================================//

    public int chamadosAtendidos(Usuario tecnico) {

        return new DAOUsuario().chamadosAtendidos(tecnico);
    }

    public int chamadosEmAtendimento(Usuario tecnico) {

        return new DAOUsuario().chamadosEmAtendimento(tecnico);
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

    public String dataHoraMysql(LocalDateTime dataHora) {
        DateTimeFormatter formatador =
                DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
        return dataHora.format(formatador);
    }

    public LocalDateTime dataHoraJava(String dataHora) {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
        return LocalDateTime.parse(dataHora, fmt);
    }
}
