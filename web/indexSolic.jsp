                            <!-- Se tem chamados mostra a tabela -->
                            <%
                                Chamado c1 = new Chamado();
                                c1.setSolicitante(usuario);
                                List<Chamado> res = new Facade().consultaChamados(c1, 0, 20);
                                if (res.size() > 0) {
                            %>
                            <div class="table-responsive no-padding">
                                <table class="table table-hover paginated">
                                    <thead>
                                    <tr>
                                        <th style="width: 10px">#</th>
                                        <th>Titulo</th>
                                        <th>Prioridade</th>
                                        <th>Status</th>
                                        <th>Data</th>

                                        <th>T�cnico</th>
                                        <th style="width: 100px">#</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for (Chamado c : res) {
                                    %>
                                    <tr>
                                        <td><%= c.getId() %>
                                        </td>
                                        <td><%= c.getTitulo() %>
                                        </td>
                                        <td><%= c.getPrioridade().toString() %>
                                        </td>
                                        <td><%= c.getStatus().toString() %>
                                        </td>
                                        <td><%= c.getData().format(DateTimeFormatter.ISO_LOCAL_DATE) %>
                                        </td>

                                        <td><%= c.getTecnico().getNome() %>
                                        </td>
                                        <td>
                                            <a style="margin-right: 20px;"
                                               href="<%= application.getContextPath() %>/Chamado/visualizar.jsp?id=<%= c.getId() %>"
                                               class="text-info" data-toggle="tooltip" title="Mais a��es"><i
                                                    class="fa fa-plus-circle"></i></a>
                                            <a href="<%= application.getContextPath() %>/Chamado/cancelar.jsp"
                                               class="text-info" data-toggle="tooltip" title="Cancelar chamado"><i
                                                    class="fa fa-trash-o"></i></a>
                                        </td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div><!-- /.box-body -->
                            <div class="clearfix">
                                <ul class="pagination pagination-sm no-margin pull-right"></ul>
                            </div>

                            <!-- Sen�o mostra uma frase -->
                            <% } else { %>

                            <p>Voc� ainda n�o possui chamados cadastrados <a href="<%= application.getContextPath() %>/Chamado/abrir.jsp">Clique aqui</a> para adicionar um.
                            </p>

                            <% } %>
