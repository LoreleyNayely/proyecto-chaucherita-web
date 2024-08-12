
<%@ page language="java" import="java.time.LocalDate" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    // Obtener la fecha actual
    LocalDate today = LocalDate.now();
%>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<script src="https://kit.fontawesome.com/ae4e5d458c.js"
	crossorigin="anonymous"></script>
<title>Dashboard</title>


</head>

<body>
	<header
		class="bg-header d-flex align-items-center flex-wrap justify-content-end p-3">

		<div class="d-flex gap-2 align-items-center justify-content-between w-100">
			<div class="d-flex gap-2 align-items-center">
				<p class="m-0 fs-5 c-darkgray">Bienvenido(a):</p>
				<a href="" class="fs-5 c-darkgray nav-link fw-bold me-4">${sessionScope.nameUser}</a>
			</div>
			<div>
				<a href="./ContabilidadController1?ruta=salir" class="nav-link">
					<span class="fs-5 c-darkgray ">Cerrar sesión</span>
					<i class="c-darkgray fa-solid fa-right-from-bracket fa-xl i-hover ml-2"></i>
				</a>
			</div>
		</div>
	</header>
	<div class="bg-content d-flex flex-column gap-4 p-3">
		<div class="w-100 px-3 py-2">
			<div
				class="bg-header rounded text-center p-3">
				<h1 class="c-darkgray card-title fs-3 mb-3 fw-bold">Cuentas:</h1>
				<div class="d-flex gap-4 contenedor-cuentas">
					<c:forEach items="${cuentas}" var="cuenta">
						<a
							data-bs-toggle="tooltip" data-bs-placement="top" title="Ver movimientos"
							href="./ContabilidadController1?ruta=verCuenta&cuentaID=${cuenta.id}"
							class="nav-link d-block w-100"
						>
							<div class="card-body mb-4 card-min-w border rounded cuenta py-1">
								<h5 class="c-gray fw-bold m-1">${cuenta.accountName}</h5>
								<p class="m-0">Saldo disponible:</p>
								<h4 class="fw-bold m-0">
									<fmt:formatNumber type="currency" value="${cuenta.balance}" />
								</h4>
							</div>
						</a>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="d-flex gap-4 px-3">
			<div class="container p-3 bg-header w-50 rounded" >
				<div class="row">
					<div class="col-12">
			            <div class="card mb-3">
			                <div class="card-body">
			                    <h4 class="text-center card-title">Saldo:</h4>
			                    <h1 class="text-center card-title">
									<fmt:formatNumber type="currency" value="${balance}" />
								</h1>
			                </div>
			            </div>
			        </div>
				</div>
				<div class="row">
			        <div class="col-6">
			            <div class="card">
			                <div class="card-body">
								<h4 class="text-center card-title">Ingresos totales:</h4>
								<h1 class="text-center card-title">
									+<fmt:formatNumber type="currency" value="${income}" />
								</h1>
			                </div>
			            </div>
			        </div>
			        <div class="col-6">
			            <div class="card">
			                <div class="card-body">
								<h4 class="text-center card-title">Gastos totales:</h4>
								<h1 class="text-center card-title">
									-<fmt:formatNumber type="currency" value="${discharge}" />
								</h1>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
			<div class="container w-50 p-3 bg-header rounded">
			    <div class="row">
			        <div class="col-6">
			            <div class="p-3 border transaccion-item d-flex flex-column gap-2 justify-content-center align-items-center" data-bs-toggle="modal" data-bs-target="#ingresoModal">
			            	<img alt="Ingreso" src="${pageContext.request.contextPath}/img/ingreso.png" />
							<p class="m-0">Registrar Ingreso</p>
			            </div>
			        </div>
			        <div class="col-6">
			            <div class="p-3 border transaccion-item d-flex flex-column gap-2 justify-content-center align-items-center" data-bs-toggle="modal" data-bs-target="#gastoModal">
			            	<img alt="Ingreso" src="${pageContext.request.contextPath}/img/egreso.png" />
			            	<p class="m-0">Registrar Gasto</p>
						</div>
			        </div>
			    </div>
			    <div class="row mt-3">
			        <div class="col-6">
			            <div class="p-3 border transaccion-item d-flex flex-column gap-2 justify-content-center align-items-center" data-bs-toggle="modal" data-bs-target="#transferModal">
			            	<img alt="Ingreso" src="${pageContext.request.contextPath}/img/transferencia.png" />
			            	<p class="m-0">Tranferencia</p>
						</div>
			        </div>
			        <div class="col-6">
			        	<a
			        		href="./ContabilidadController1?ruta=verMovimientos"
			        		class="nav-link transaccion-item"
			        	>
				            <div class="p-3 border transaccion-item d-flex flex-column gap-2 justify-content-center align-items-center">
				            	<img alt="Ingreso" src="${pageContext.request.contextPath}/img/movimientos.png" />
				            	<p class="m-0">Ver todos los movimientos</p>
				            </div>
			        	</a>
			        </div>
			    </div>
			</div>
		</div>
	</div>
	<div class="d-flex">
		<div class="w-50">
			<div class="accordion accordion-flush" id="accordionFlushIngresos">
				  <div class="accordion-item">
				    <h2 class="accordion-header" id="flush-headingOne">
				      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOneIngresos" aria-expanded="false" aria-controls="flush-collapseOneIngresos">
				        <h3 class="">Ingresos</h3>
				      </button>
				    </h2>
				    <div id="flush-collapseOneIngresos" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushIngresos">
				      	<div class="accordion-body px-2" >
					      	<div class="">
						      	<c:forEach items="${categoriasI}" var="categoria">
						      		<a
						      			data-bs-toggle="tooltip" data-bs-placement="top" title="Ver movimientos"
										href="./ContabilidadController1?ruta=verCategoria&catID=${categoria.id}"
										class="nav-link d-block w-100"
						      		>
						      			<div class="card-body mb-2 transaccion-item px-2">
											<h5 class="c-gray fw-bold m-1">${categoria.categoryName}</h5>
			
											<h4 class="fw-bold  m-0">
												+<fmt:formatNumber type="currency" value="${categoria.value}" />
											</h4>
										</div>
						      		</a>
								</c:forEach>
							</div>
						</div>
				    </div>
				  </div>
				</div>
		</div>	
		<div class="w-50">
			<div class="accordion accordion-flush" id="accordionFlushEgresos">
				  <div class="accordion-item">
				    <h2 class="accordion-header" id="flush-headingOne">
				      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
				        <h3 class="">Egresos</h3>
				      </button>
				    </h2>
				    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushEgresos">
				      	<div class="accordion-body px-2" >
				     	 	<c:forEach items="${categoriasG}" var="categoria">
				     	 		<a
					      			data-bs-toggle="tooltip" data-bs-placement="top" title="Ver movimientos"
									href="./ContabilidadController1?ruta=verCategoria&catID=${categoria.id}"
									class="nav-link d-block w-100"
				     	 		>
									<div class="card-body mb-2 transaccion-item px-2">
										<h5 class="c-gray fw-bold m-1">${categoria.categoryName}</h5>
	
										<h4 class="fw-bold  m-0">
											<fmt:formatNumber type="currency" value="-${categoria.value}" />
										</h4>
									</div>
				     	 		</a>
							</c:forEach>
							</div>
						</div>
				    </div>
				  </div>
				</div>
		</div>		
	</div>
	
	<div class=" modal fade" id="gastoModal" tabindex="-1"
		aria-labelledby="gastoModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header font-w-bold">
					<h1 class="modal-title fs-5 fw-bold" id="gastoModalLabel">Registrar gasto</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="RegistrarMovimientosController?ruta=registrarEgreso" method="POST">
						<label for="categoria" class="form-label">Categoría:</label> <select
							class="form-select" id="categoria" name="categoria">
							<option selected hidden></option>
							<c:forEach items="${categoriasG}" var="categoria">
								<option value="${categoria.id}">${categoria.categoryName}</option>
							</c:forEach>
						</select> <label for="descripcion" class="form-label">Descripción:</label>
						<textarea class="form-control" id="descripcion" name="descripcion"
							rows="1"></textarea>
					  <label for="fecha" class="form-label">Fecha:</label> <input
							type="date" class="form-control" value="<%= today %>" disabled name="fecha" id="fecha">
						<label for="monto" class="form-label">Monto:</label> <input
							type="text" name="monto" id="monto" oninput="formatMoney(this)"
							class="form-control" required> <label for="cuenta"
							class="form-label">Cuenta:</label> <select class="form-select"
							id="cuenta" name="cuenta">
							<option selected hidden></option>
							<c:forEach items="${cuentas}" var="cuenta">
								<option value="${cuenta.id}">${cuenta.accountName}</option>
							</c:forEach>
						</select>
						<div class="modal-footer">
							<button type="button" class="btn btn-outline-dark"
								data-bs-dismiss="modal">Cerrar</button>
							<button type="submit" class="btn btn-indigo">Guardar</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="transferModal" tabindex="-1"
		aria-labelledby="transferModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header font-w-bold">
					<h1 class="modal-title fs-5 fw-bold" id="transfereModalLabel">
						Transferencia</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="RegistrarMovimientosController?ruta=transferir" method="POST">
						<label for="descripcion" class="form-label">Descripción:</label>
						<textarea class="form-control" id="descripcion" name="descripcion"
							rows="1"></textarea>
					 <label for="fecha" class="form-label">Fecha:</label> <input
							type="date" class="form-control" value="<%= today %>" disabled name="fecha" id="fecha">
						
						<label for="monto" class="form-label">Monto:</label> <input
							type="text" name="monto" id="monto" oninput="formatMoney(this)"
							class="form-control" required> <label for="origen"
							class="form-label">Origen:</label> <select class="form-select"
							id="origen" name="origen">
							<option selected hidden></option>
							<c:forEach items="${cuentas}" var="cuenta">
								<option value="${cuenta.id}">${cuenta.accountName}</option>
							</c:forEach>
						</select> <label for="destino" class="form-label">Destino:</label> <select
							class="form-select" id="destino" name="destino">
							<option selected hidden></option>
							<c:forEach items="${cuentas}" var="cuenta">
								<option value="${cuenta.id}">${cuenta.accountName}</option>
							</c:forEach>
						</select>
						<div class="modal-footer">
							<button type="button" class="btn btn-outline-dark"
								data-bs-dismiss="modal">Cerrar</button>
							<button type="submit" class="btn btn-indigo">Guardar</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
	<div class="modal fade" id="ingresoModal" tabindex="-1"
		aria-labelledby="ingresoModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header font-w-bold">
					<h1 class="modal-title fs-5 fw-bold" id="ingresoModalLabel">Ingreso</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="RegistrarMovimientosController?ruta=registrarIngreso" method="POST">
						<label for="categoria" class="form-label">Categoría:</label> <select
							class="form-select" id="categoria" name="categoria">
							<option selected hidden></option>
							<c:forEach items="${categoriasI}" var="categoria">
								<option value="${categoria.id}">${categoria.categoryName}</option>
							</c:forEach>
						</select> <label for="descripcion" class="form-label">Descripción:</label>
						<textarea class="form-control" id="descripcion" name="descripcion"
							rows="1"></textarea>
						<label for="fecha" class="form-label">Fecha:</label> <input
							type="date" class="form-control" value="<%= today %>" name="fecha" id="fecha" disabled>
						<label for="monto" class="form-label">Monto:</label> <input
							type="text" name="monto" id="monto" oninput="formatMoney(this)"
							class="form-control" required> <label for="pago"
							class="form-label">Cuenta:</label> <select class="form-select"
							id="cuenta" name="cuenta">
							<option selected hidden></option>
							<c:forEach items="${cuentas}" var="cuenta">
								<option value="${cuenta.id}">${cuenta.accountName}</option>
							</c:forEach>
						</select>
						<div class="modal-footer">
							<button type="button" class="btn btn-outline-dark"
								data-bs-dismiss="modal">Cerrar</button>
							<button type="submit" class="btn btn-indigo">Guardar</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
	<script>
		function formatMoney(input) {
			let value = input.value.replace(/[^\d.]/g, ''); // Remover caracteres no numéricos excepto punto
			value = value.replace(/(\..*?)\..*/g, '$1'); // Permitir solo un punto decimal

			// Si hay un punto decimal, asegurarse de que no se ingrese otro punto a la derecha
			if (value.indexOf('.') !== -1) {
				const parts = value.split('.');
				value = parts[0] + '.' + parts[1].substr(0, 2);
			}

			input.value = '$' + value; // Agregar símbolo de moneda
		}
	</script>
	<script
		src=" https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
		crossorigin="anonymous"></script>

	<script>
	    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
	        return new bootstrap.Tooltip(tooltipTriggerEl)
	    })
	</script>
</body>

</html>