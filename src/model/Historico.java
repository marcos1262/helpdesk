package model;

import java.time.LocalDateTime;

/**
 * Registro de uma ação importante realizada no sistema
 *
 * @author marcos
 */
public class Historico {
    private long id;
    private acoes acao;
    private String justificativa;
    private LocalDateTime hora;
    private Usuario usuario1;
    private Chamado chamado;
    private Usuario usuario2;
    
    public enum acoes {
        ABRIR_CHAMADO("abriu o chamado"),
        INCREMENTAR_DESCRICAO("incrementou a descrição do chamado"),
        CANCELAR_CHAMADO("cancelou o chamado"),
        ALTERAR_PRIORIDADE("alterou a prioridade do chamado"),
        ALTERAR_STATUS("alterou os status do chamado"),
        ASSUMIR_CHAMADO("assumiu o chamado"),
        TRANSFERIR_CHAMADO("transferiu o chamado"),
        CADASTRAR_USUARIO("cadastrou o usuario"),
        ALTERAR_USUARIO("alterou o usuario");
        
        private final String descricao;

        acoes(String value) {
            descricao = value;
        }

        public String getDescricao() {
            return descricao;
        }
    }

    public acoes getAcao() {
        return acao;
    }

    public void setAcao(acoes acao) {
        this.acao = acao;
    }

    public String getJustificativa() {
        return justificativa;
    }

    public void setJustificativa(String justificativa) {
        this.justificativa = justificativa;
    }

    public LocalDateTime getHora() {
        return hora;
    }

    public void setHora(LocalDateTime hora) {
        this.hora = hora;
    }

    public Usuario getUsuario1() {
        return usuario1;
    }

    public void setUsuario1(Usuario usuario1) {
        this.usuario1 = usuario1;
    }

    public Chamado getChamado() {
        return chamado;
    }

    public void setChamado(Chamado chamado) {
        this.chamado = chamado;
    }

    public Usuario getUsuario2() {
        return usuario2;
    }

    public void setUsuario2(Usuario usuario2) {
        this.usuario2 = usuario2;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}
