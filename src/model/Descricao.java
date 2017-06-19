package model;

public class Descricao {
    private long id;
    private String descricao;

    public Descricao(long id, String descricao) {
        this.id = id;
        this.descricao = descricao;
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

}
