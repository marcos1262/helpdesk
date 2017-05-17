<%@ page import="model.Usuario" %>
<%@ page import="model.Facade" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        String login = request.getParameter("usuario"),
                senha = request.getParameter("senha");

        if (login != null && senha != null)
            if (login.equals(""))
                out.print("<script>alert('O campo usuário é obrigatório!');</script>");
            else if (senha.equals(""))
                out.print("<script>alert('O campo senha é obrigatório!');</script>");
            else {
                Facade f = new Facade();
                // TODO criptografar senha com MD5
                Usuario usuario1 = f.autentica(login, senha);

                if (usuario1 == null)
                    out.print("<script>alert('Login ou senha incorretos!');</script>");
                else
                    session.setAttribute("usuario", usuario1);
            }
    }
%>