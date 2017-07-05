package model;

import java.time.LocalDateTime;

public class Descricao {
    private long id;
    private String descricao;
    private LocalDateTime data;
    private Usuario autor;

    public Descricao(long id, String descricao, LocalDateTime data, Usuario autor) {
        this.id = id;
        this.descricao = descricao;
        this.data = data;
        this.autor = autor;
    }

    public Descricao(String descricao, LocalDateTime data, Usuario autor) {
        this.descricao = descricao;
        this.data = data;
        this.autor = autor;
    }



    public Descricao(String descricao) {
        this.descricao = descricao;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public LocalDateTime getData() {
        return data;
    }

    public void setData(LocalDateTime data) {
        this.data = data;
    }

    public Usuario getAutor() {
        return autor;
    }

    public void setAutor(Usuario autor) {
        this.autor = autor;
    }

}
