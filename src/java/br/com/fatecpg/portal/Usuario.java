package br.com.fatecpg.portal;

import java.util.ArrayList;

public class Usuario {
    private long cod;
    private String usuario;
    private String senha;
    private String nome;
    private String curso;
    private String permissao;

    public Usuario(long cod, String usuario, String senha, String nome, String curso, String permissao) {
        this.cod = cod;
        this.usuario = usuario;
        this.senha = senha;
        this.nome = nome;
        this.curso = curso;
        this.permissao = permissao;
    }

    public long getCod() {
        return cod;
    }

    public void setCod(long cod) {
        this.cod = cod;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCurso() {
        return curso;
    }

    public void setCurso(String curso) {
        this.curso = curso;
    }

    public String getPermissao() {
        return permissao;
    }

    public void setPermissao(String permissao) {
        this.permissao = permissao;
    }
    
    public static Usuario getUsuario(String login, String senha) throws Exception {
        
        String SQL = "SELECT * FROM TB_USUARIO WHERE NM_LOGIN = ? AND NM_SENHA = ?";
        Object parameters[] = {login, senha.hashCode()};
        
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, parameters);
        if (list.isEmpty()){
            return null;
        } else {
            Object row[] = list.get(0);
            Usuario u = new Usuario(
                    (long) row[0], 
                    (String) row[1], 
                    (String) row[2], 
                    (String) row[3], 
                    (String) row[4],
                    (String) row[5]);
            return u;
        }
    }
    
    public static ArrayList<Usuario> getUsers() throws Exception {
        String SQL = "SELECT * FROM USERS";
        ArrayList<Usuario> usuarios = new ArrayList<>();
        ArrayList<Object[]> list = DatabaseConnector.getQuery(SQL, new Object[]{});
        for (int i = 0; i < list.size(); i++) {
            Object row[] = list.get(i);
            Usuario u = new Usuario(
                    (long) row[0], 
                    (String) row[1], 
                    (String) row[2], 
                    (String) row[3], 
                    (String) row[4],
                    (String) row[5]);
            usuarios.add(u);
        }
        return usuarios;
    }
    
    public static void adicionarUsuario (String role, String name, String login, long passwordHash) throws Exception{
        String SQL = "INSERT INTO USUARIO VALUES (default, ? , ? , ? , ? )";
        Object parameters[] = {role, name, login, passwordHash};
        DatabaseConnector.execute(SQL, parameters);
    }
    
    public static void removerUsuario(long id) throws Exception{
        String SQL = "DELETE FROM TB_USUARIO WHERE CD_USUARIO = ?";
        Object parameters[] = {id};
        DatabaseConnector.execute(SQL, parameters);
    }
}
