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
    <script>
    	function detalhes(id){
    		let formulario = document.getElementById('fForm');
    		formulario.id.value = id;
	    	formulario.action = 'crud_lista.asp';
	    	formulario.submit();
    	}
    	function carrega(){
    		//Validação da documentação
    		let divRG = document.getElementById('DivRG');
    		divRG.style.display = 'none';

    		let divCPF = document.getElementById('DivCPF');
    		divCPF.style.display = 'none';
    	}
    	function MostraDivDoc(tipoDoc){
    		let divRG = document.getElementById('DivRG');
    		let divCPF = document.getElementById('DivCPF');
    		if(tipoDoc == 1){
    			divRG.style.display = 'block';
    			divCPF.style.display = 'none';    			
    		}
    		else if(tipoDoc == 2){
    			divCPF.style.display = 'block';
    			divRG.style.display = 'none';	
    		}
    	}
    </script>
  </head>
  <body onload="carrega();">
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
				  		<form id="fForm" method="POST">
				  			<input type="hidden" name="id" value="">
					  		<%if not busca.eof then%>
					  			<%do while not busca.eof%>
								    <tr onclick="detalhes('<%=busca.fields("pessoa_id")%>')">
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
						  </form>
					</tbody>
				</table>	
			</div>
		</div>
		<div class="row">
		  <div class="col-md-4"></div>
		  <div class="col-md-4 offset-md-4">
		  	<button class="btn btn-primary" data-toggle="modal" data-target="#InclusaoModal">Incluir novo registro</button>
		  </div>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="InclusaoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Ficha de Inscrição</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form name="FormModalInserir">
						<div class="form-row">
					    <div class="form-group col-md-4">
					      <label for="InputOrdem">Ordem</label>
					      <input type="number" class="form-control" id="InputOrdem" value="2" name="Ordem">
					    </div>
					    <div class="form-group col-md-8">
					      <label for="InputNome">Nome</label>
					      <input type="text" class="form-control" id="InputNome" name="Nome">
					    </div>
					  </div>
					  <div class="form-row">
					  	<div class="form-group col-md-4">
					      <label for="TipoDocumento">Tipo de documento</label>
					      <select id="TipoDocumento" class="form-control" name="TipoDocumento" onchange="MostraDivDoc(this.value)">
					        <option value="" selected disabled>>> Selecione <<</option>
					        <option value="1">RG</option>
					        <option value="2">CPF</option>
					      </select>
					    </div>
					    <div class="form-group col-md-8" id="DivRG">
					    	<label for="Documentacao">Documentação</label>
					    	<input type="text" class="form-control" id="Documentacao" name="Documentacao" value="" placeholder="xx.xxx.xxx-x">
					    </div>
					    <div class="form-group col-md-8" id="DivCPF">
					    	<label for="Documentacao">Documentação</label>
					    	<input type="text" class="form-control" id="Documentacao" name="Documentacao" value="xxx.xxx.xxx-xx">
					    </div>
					  </div>
					  <div class="form-row">
					  	<div class="form-group col-md-8">
					      <label for="Endereco">Endereço</label>
					      <input type="text" class="form-control" id="Endereco" name="Endereco">
					    </div>
					    <div class="form-group col-md-4" id="DivRG">
					    	<label for="Contato">Contato</label>
					    	<input type="text" class="form-control" id="Contato" name="Contato">
					    </div>
					  </div>
					</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
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