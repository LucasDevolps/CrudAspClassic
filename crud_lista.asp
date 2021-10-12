<%
	if len(session("conexao")) = 0 then
		response.redirect "perda_de_sessao.asp"
	end if

	SQL = "SELECT CASE WHEN DOC_ID = 1 THEN SUBSTRING(DOCUMENTO,0,3)+'.'+SUBSTRING(DOCUMENTO,3,3)+'.'+SUBSTRING(DOCUMENTO,6,3)+'-'+SUBSTRING(DOCUMENTO,8,2) WHEN DOC_ID = 2 THEN SUBSTRING(DOCUMENTO,0,4)+'.'+SUBSTRING(DOCUMENTO,3,3)+'.'+SUBSTRING(DOCUMENTO,6,3)+'-'+SUBSTRING(DOCUMENTO,8,2) END AS DOCUMENTACAO, CASE WHEN CONT_ID = 1 THEN '('+SUBSTRING(CONTATO,1,2)+') '+SUBSTRING(CONTATO,3,5)+' - '+SUBSTRING(CONTATO,8,9) ELSE SUBSTRING(CONTATO,1,20)+'...' END AS CONTATOS, * FROM PESSOAS	"
	set busca = session("conexao").execute(SQL)
%>
<!doctype html>
<html lang="pt-BR">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>Crud  com asp classic</title>
    <style>
    	table tbody tr,td {
    		cursor: pointer;
    	}
    	@media only screen and (max-width: 600px) {
    			table{
    				width: 100%;
    			}
    	}
    </style>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <a class="navbar-brand" href="crud_lista.asp">Inicio</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navbarNav">
	    <ul class="navbar-nav">
	      <li class="nav-item active">
	        <a class="nav-link" href="crud_lista.asp">Listar <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">Features</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">Pricing</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">Disabled</a>
	      </li>
	    </ul>
	  </div>
	</nav>
	<div class="container">
		<div class="row">
			<div class="col-md-10" style="margin: auto; margin-top: 5%;">
				<table class="table text-center table-hover">
					<thead>
					    <tr>
					      	<th scope="col">N°</th>
					      	<th scope="col">Nome</th>
					      	<th scope="col">Documento</th>
					      	<th scope="col">Endereço</th>
					      	<th scope="col">Contato</th>
					    </tr>
				  	</thead>
				  	<tbody>
				  		<%if not busca.eof then%>
				  			<%do while not busca.eof%>
							    <tr>
							    	<th scope="row"><%=busca.fields("pessoa_id")%></th>
							      	<td><%=busca.fields("nome")%></td>
							      	<td><%=busca.fields("documentacao")%></td>
							      	<td><%=busca.fields("endereco")%></td>
							      	<td><%=busca.fields("contatos")%></td>
							    </tr>
							    <%busca.movenext%>
						    <%loop%>
						<%else%>
							<tr>
								<th scope="row" colspan="5">Nenhum registro encontrado...</th>
							</tr>
					    <%end if%>
					</tbody>
				</table>
			</div>
		</div>
	</div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </body>
</html>