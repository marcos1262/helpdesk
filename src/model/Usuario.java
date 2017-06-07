package model;

import java.io.Serializable;

/**
 * Usuário do sistema (Administrador, Técnico ou Solicitante)
 *
 * @author marcos
 */
public class Usuario implements Serializable {
    private long id;
    private String nome,
            usuario,
            senha;
    private tipos tipo;

    public enum tipos {
        ADMIN,  // Adminstrador
        TECNI,  // Técnico
        SOLIC   // Solicitante
    }

    public Usuario(long id) {
        this.id = id;
    }

    public Usuario(String usuario, String senha) {
        this.usuario = usuario;
        this.senha = senha;
    }

    public Usuario(String nome, String usuario, String senha, tipos tipo) {
        this.nome = nome;
        this.usuario = usuario;
        this.senha = senha;
        this.tipo = tipo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public boolean validaSenha(Usuario usuario) {
        return usuario.senha.equals(this.senha);
    }
    
    public String getSenha() {
        return senha;
    }
    
    public void setSenha(String senha) {
        this.senha = senha;
    }

    public tipos getTipo() {
        return tipo;
    }

    public void setTipo(tipos tipo) {
        this.tipo = tipo;
    }

    public void setTipo(String tipo) {
        switch (tipo) {
            case "ADMIN":
                this.tipo = tipos.ADMIN;
                break;
            case "TECNI":
                this.tipo = tipos.TECNI;
                break;
            case "SOLIC":
                this.tipo = tipos.SOLIC;
                break;
        }
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", usuario='" + usuario + '\'' +
                ", senha='" + senha + '\'' +
                ", tipo=" + tipo +
                '}';
    }
}
