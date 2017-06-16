<%@page import="model.Descricao"%>
<%@page import="model.Chamado"%>
<%@ page import="model.Facade" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    
    <%
    
        Chamado c = new Chamado();
        
        c.setId(Long.parseLong(request.getParameter("id")));
        c.setTitulo(request.getParameter("prioridade"));
        //c.setStatus(request.getParameter("status"));
        
        new Facade().atualizaChamado(c);
        
        String desc = request.getParameter("adddesc");
        
        if(desc != ""){
        
            new Facade().addDescricao(c.getId(), new Descricao(desc));
        }
        
        pageContext.forward("../index.jsp");
        
        
    %>
    
    
    
    
    
</html>