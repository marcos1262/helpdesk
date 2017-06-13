<%@ page import="model.Usuario" %>
<%@ page import="model.Usuario" %>
<%@ page import="model.Facade" %>
<%@ page import="model.Chamado" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp" %>
 
<h1>
    Bem vindo, <%=usuario.getNome()%>
</h1>
<br>
Crie seu chamado:
<br>
<form name="chamado" action="index.jsp" method="post">
    <input type="text" name="titulo" value="Título"/>
    <input type="text" name="prioridade" value="Prioridade"/>
    <input type="text" name="descricao" value="Descrição"/>
    <input type="submit" name="gerar" value="Criar chamado"/>
</form>

<%
    /*String titulo=request.getParameter("titulo");
    String prioridade=request.getParameter("prioridade");
    String descricao=request.getParameter("descricao");
    if(titulo != null && prioridade != null && descricao != null){
        if(titulo.equals("")){
            out.print("<script>alert('O campo titulo Ã© obrigatÃ³rio!');</script>");
        }
        if(prioridade.equals("")){
            out.print("<script>alert('O campo prioridade Ã© obrigatÃ³rio!');</script>");
        }
        if(descricao.equals("")){
            out.print("<script>alert('O campo descricao Ã© obrigatÃ³rio!');</script>");
        }
    }
    Facade fachada= new Facade();
    fachada.abreChamado(titulo, prioridade, descricao, usuario.getId());*/
%>

<form name="Sair" action="index.jsp" method="post">
    <input type="submit" name="Sair" value="Sair"/>
</form>

<%
    boolean result = request.getParameter("Sair") != null;
    if (result) {
        session.invalidate();
        response.sendRedirect("login.jsp");
    }
%>


<%--

<%--
new Facade().abreChamado("teste", "ALTA", "I'm with problems", usuario.getId());
--%>

<%--TESTANDO consultaChamados--%>
<%--
Chamado c1 = new Chamado();
c1.setTitulo("teste");
out.println("OK");
List<Chamado> res = new Facade().consultaChamados(c1, 0, 20);
for (Chamado c : res) {
    out.println("C:" + c.getId());
}
--%>
%>

</body>
        <%
            }
        %>
</html>
