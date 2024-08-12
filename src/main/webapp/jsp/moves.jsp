<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<title>Movimientos</title>
</head>

<body class="bg-content">
	<header
		class="bg-header d-flex align-items-center flex-wrap justify-content-end p-3">

		<div class="d-flex gap-2 align-items-center justify-content-between w-100">
			<div class="d-flex gap-2 align-items-center">
				<p class="m-0 fs-5 c-darkgray">Bienvenido(a):</p>
				<a href="./ContabilidadController1?ruta=verDashboard" class="fs-5 c-darkgray nav-link fw-bold me-4">${sessionScope.nameUser}</a>
			</div>
			<div>
				<a href="./ContabilidadController1?ruta=salir" class="nav-link">
					<span class="fs-5 c-darkgray ">Cerrar sesión</span>
					<i class="c-darkgray fa-solid fa-right-from-bracket fa-xl i-hover ml-2"></i>
				</a>
			</div>
		</div>
	</header>
	<div class="container py-5">
		<div class="card mb-4 rounded-3 shadow-sm">
			<div
				class="card-header d-flex justify-content-center py-3">
				<c:choose>
					<c:when test="${verTipo eq 'Todas'}">
						<form action="ContabilidadController1?ruta=verMovimientos"
							method="POST" class="text-center w-100">
							<h1 class=" my-3">${accountName}</h1>
							<div class="d-flex gap-4 justify-content-center align-items-center">
								<div class="d-flex gap-2 justify-content-center align-items-center w-100">
									<p class="m-0">Fecha Inicio:</p>
									<input type="date"
										value="${startDate}"
										class="text-center border form-control w-50"
										 name="fechaInicio" id="fechaInicio">
								</div>
								<div class="d-flex gap-2 justify-content-center align-items-center w-100">
									<p class="m-0">Fecha Fin:</p>
									<input type="date"
									value="${endDate}"
										class="text-center border form-control w-50"
										 name="fechaFin" id="fechaFin">
								</div>	
								<button type="submit" class="btn btn-indigo fw-bold">Actualizar</button>
							</div>
						</form>
					</c:when>
					<c:when test="${verTipo eq 'Cuenta'}">
						<form
							action="ContabilidadController1?ruta=verCuenta&cuentaID=${cuentaID}"
							method="POST" class="text-center w-100">
							<h1 class=" my-3">${accountName}</h1>
							<div class="d-flex gap-4 justify-content-center align-items-center">
								<div class="d-flex gap-2 justify-content-center align-items-center w-100">
									<p class="m-0">Fecha Inicio:</p>
									<input type="date"
										value="${startDate}"
										class="text-center border form-control w-50"
										 name="fechaInicio" id="fechaInicio">
								</div>
								<div class="d-flex gap-2 justify-content-center align-items-center w-100">
									<p class="m-0">Fecha Fin:</p>
									<input type="date"
									value="${endDate}"
										class="text-center border form-control w-50"
										 name="fechaFin" id="fechaFin">
								</div>	
								<button type="submit" class="btn btn-indigo fw-bold">Actualizar</button>
							</div>
								
						</form>
					</c:when>
					<c:when test="${verTipo eq 'Cat'}">
						<form
							action="ContabilidadController1?ruta=verCategoria&catID=${catID}"
							method="POST" class="text-center w-100">
							<h1 class="fw-bold my-3">${accountName}</h1>
							<div class="d-flex gap-4 justify-content-center align-items-center">
								<div class="d-flex gap-2 justify-content-center align-items-center w-100">
									<p class="m-0">Fecha Inicio:</p>
									<input type="date"
										value="${startDate}"
										class="text-center border form-control w-50"
										 name="fechaInicio" id="fechaInicio">
								</div>
								<div class="d-flex gap-2 justify-content-center align-items-center w-100">
									<p class="m-0">Fecha Fin:</p>
									<input type="date"
									value="${endDate}"
										class="text-center border form-control w-50"
										 name="fechaFin" id="fechaFin">
								</div>								
								<button type="submit" class="btn btn-indigo fw-bold">Actualizar</button>
							</div>
						</form>
					</c:when>
				</c:choose>


			</div>
			<table class="table">
				<thead>
					<tr>
						<th class="fw-bold fs-4" scope="col">Fecha</th>
						<th class="fw-bold fs-4" scope="col">Cuenta Origen</th>
						<th class="fw-bold fs-4" scope="col">Cuenta Destino</th>
						<th class="fw-bold fs-4" scope="col">Monto</th>
						<th class="fw-bold fs-4" scope="col">Categoría</th>
						<th class="fw-bold fs-5" scope="col">Descripción</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${movimientos}" var="movimiento">
						<tr>
							<th class="fs-5" scope="row">${movimiento.date}</th>
							<td class="fs-5">${movimiento.accountO.accountName}</td>
							<td class="fs-5">${movimiento.accountD.accountName}</td>


							<td class="fs-5">
							    <c:choose>
							        <c:when test="${movimiento.category.type == 'INCOME'}">
							            +${movimiento.amount}
							        </c:when>
							        <c:otherwise>
							            -${movimiento.amount}
							        </c:otherwise>
							    </c:choose>
							</td>
							<td class="fs-5">${movimiento.category.categoryName}</td>
							<td class="fs-5">${movimiento.description}</td>
							<td>
								<button type="button" class="btn btn-sm delete-btn"
									data-id="${movimiento.id}" data-amount="${movimiento.amount}"
									data-accountO-id="${movimiento.accountO.id}"
									data-accountD-id="${movimiento.accountD.id}"
									data-verTipo="${verTipo}"
									data-category-id="${movimiento.category.id}">
									<i class="fa-solid fa-trash fa-xl text-danger"></i>
								</button>
							</td>

						</tr>

					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<script>
		const deleteButtons = document.querySelectorAll('.delete-btn');

		deleteButtons
				.forEach(function(deleteButton) {
					deleteButton
							.addEventListener(
									'click',
									function() {
										const deleteUrl = 'RegistrarMovimientosController?ruta=eliminarMovimiento&movimientoId='
												+ this.getAttribute('data-id')
												+ '&amount='
												+ this
														.getAttribute('data-amount')
												+ '&accountIdO='
												+ this
														.getAttribute('data-accountO-id')
												+ '&accountIdD='
												+ this
														.getAttribute('data-accountD-id')
												+ '&verTipo='
												+ this
														.getAttribute('data-verTipo')
												+ '&categoryId='
												+ this
														.getAttribute('data-category-id');
										
										fetch(deleteUrl,{
											method:"POST"
										}).then(()=>{
											window.location.reload();

										})
									});
				});
	</script>



	<script
		src=" https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
		crossorigin="anonymous"></script>
</body>

</html>