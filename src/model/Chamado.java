package model;

import java.time.LocalDateTime;

/**
 * Chamado realizado por um solicitante (@see {@link Usuario}) e atendido por um técnico (@see {@link Usuario})
 * @author marcos
 */
public class Chamado {
    private int id;
    private String titulo;
    private prioridades prioridade;
    private status status;
    private LocalDateTime data;
    private Usuario solicitante,
                    tecnico;

    public enum prioridades {
        ALTA,
        NORMAL,
        BAIXA
    }

    public enum status {
        ABERTO,             // Ainda não foi avaliado por um técnico
        ATENDENDO,          // Um técnico se prontificou em atender
        ESPERANDO,          // Ainda não pode ser atendido
        FECHADO_SUCESSO,    // Foi atendido com sucesso
        FECHADO_FALHA,      // Não foi possível resolver o problema
        FECHADO_CANCELADO   // O usuário cancelou o chamado
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public prioridades getPrioridade() {
        return prioridade;
    }

    public void setPrioridade(prioridades prioridade) {
        this.prioridade = prioridade;
    }

    public Chamado.status getStatus() {
        return status;
    }

    public void setStatus(Chamado.status status) {
        this.status = status;
    }

    public LocalDateTime getData() {
        return data;
    }

    public void setData(LocalDateTime data) {
        this.data = data;
    }

    public Usuario getSolicitante() {
        return solicitante;
    }

    public void setSolicitante(Usuario solicitante) {
        this.solicitante = solicitante;
    }

    public Usuario getTecnico() {
        return tecnico;
    }

    public void setTecnico(Usuario tecnico) {
        this.tecnico = tecnico;
    }
}
