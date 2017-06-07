package model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Chamado realizado por um solicitante (@see {@link Usuario}) e atendido por um técnico (@see {@link Usuario})
 *
 * @author marcos
 */
public class Chamado {
    private long id;
    private String titulo;
    private prioridades prioridade;
    private statusOpcoes status;
    private LocalDateTime data;
    private Usuario solicitante,
            tecnico;
    private List<String> descricoes;

    public Chamado(long id, String descrição) {
        this.id = id;
        addDescrição(descrição);
    }

    public Chamado() {
    }

    final void addDescrição(String descricao) {
        if(descricoes==null)
            descricoes = new ArrayList<>();
        descricoes.add(descricao);
    }

    public enum prioridades {
        ALTA,
        NORMAL,
        BAIXA
    }

    public enum statusOpcoes {
        ABERTO,             // Ainda não foi avaliado por um técnico
        ATENDENDO,          // Um técnico se prontificou em atender
        ESPERANDO,          // Ainda não pode ser atendido
        FECHADO_SUCESSO,    // Foi atendido com sucesso
        FECHADO_FALHA,      // Não foi possível resolver o problema
        FECHADO_CANCELADO   // O usuário cancelou o chamado
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
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

    public void setPrioridade(String prioridade) {
        switch (prioridade) {
            case "ALTA":
                this.prioridade = prioridades.ALTA;
                break;
            case "NORMAL":
                this.prioridade = prioridades.NORMAL;
                break;
            case "BAIXA":
                this.prioridade = prioridades.BAIXA;
                break;
        }
    }

    public statusOpcoes getStatus() {
        return status;
    }

    public void setStatus(String status) {
        switch (status) {
            case "ABERTO":
                this.status = statusOpcoes.ABERTO;
                break;
            case "ATENDENDO":
                this.status = statusOpcoes.ATENDENDO;
                break;
            case "ESPERANDO":
                this.status = statusOpcoes.ESPERANDO;
                break;
            case "FECHADO_SUCESSO":
                this.status = statusOpcoes.FECHADO_SUCESSO;
                break;
            case "FECHADO_FALHA":
                this.status = statusOpcoes.FECHADO_FALHA;
                break;
            case "FECHADO_CANCELADO":
                this.status = statusOpcoes.FECHADO_CANCELADO;
                break;
        }
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

    public List<String> getDescricoes() {
        return descricoes;
    }

    public void setDescricoes(List<String> descricoes) {
        this.descricoes = descricoes;
    }

    @Override
    public String toString() {
        return "Chamado{" +
                "id=" + id +
                ", titulo='" + titulo + '\'' +
                ", prioridade=" + prioridade +
                ", status=" + status +
                ", data=" + data +
                ", solicitante=" + solicitante +
                ", tecnico=" + tecnico +
                ", descricoes=" + descricoes +
                '}';
    }
}
