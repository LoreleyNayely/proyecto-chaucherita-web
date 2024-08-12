<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
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
<title>Error Movimiento</title>
</head>
<body class="bg-content">
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
	<div
		class="modal modal-sheet position-static d-block p-4 py-md-5"
		tabindex="-1" role="dialog" id="modalTour">
		<div class="modal-dialog" role="document">
			<div class="modal-content rounded-4 shadow">
				<div class="modal-body p-5">
					<h2 class="fw-bold mb-0 text-center">
						Ha ocurrido un error <i class="fa-solid text-danger fa-triangle-exclamation"></i>
					</h2>

					<ul class="d-grid gap-4 my-5 list-unstyled small">

						<li class="d-flex flex-column gap-3 align-items-center">

							<h2 class="mb-0">Tu saldo es insuficiente</h2> 
							No se ha podido realizar tu movimiento

						</li>
					</ul>
					<a href="../ContabilidadController1?ruta=verDashboard" type="button"
						class="btn btn-indigo fw-bold btn btn-lg mt-1 w-100"
						data-bs-dismiss="modal">Volver</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>