package controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.DAO.DAOFactory;
import model.entidades.Account;
import model.entidades.Category;
import model.entidades.Move;
import model.entidades.Type;
import model.entidades.User;

@WebServlet("/ContabilidadController1")
public class ContabilidadController1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ContabilidadController1() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		Siempre se Redirecciona
		this.ruteador(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		Siempre se Redirecciona
		this.ruteador(request, response);
	}

	private void ruteador(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String ruta = (request.getParameter("ruta") == null) ? "inicio" : request.getParameter("ruta");

		switch (ruta) {
		case "inicio":
			this.inicio(request, response);
			break;
		case "verDashboard":
			this.verDashboard(request, response);
			break;
		case "salir":
			this.salir(request, response);
			break;
		case "error":
			this.error(request, response);
			break;
//			C.U: Ver Movmientos
		case "verMovimientos":
			System.out.println("estamos en movimientos 1");
			this.verMovimientos(request, response);
			break;
		case "verCuenta":
			int cuentaID = Integer.parseInt(request.getParameter("cuentaID"));
			System.out.println(cuentaID);
			System.out.println("estamos en ver movimientos por Cuenta");
			this.verCuenta(request, response, cuentaID);
			break;
		/*case "filtrarPorMesContable"
			this.filtrarPorMesContable(request, response);
			break;
			*/

		case "verCategoria":
			int catID = Integer.parseInt(request.getParameter("catID"));
			String startDate = request.getParameter("fechaInicio");
			System.out.println("estamos en ver movimientos por Categoria " + startDate);
			this.verCategoria(request, response, catID);
			break;
		default:
			break;
		}
	}

	private void error(HttpServletRequest request, HttpServletResponse response) throws IOException {

		response.sendRedirect("jsp/moveError.jsp");
	}

	private void inicio(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 1.- Obtener datos que me envï¿½an en la solicitud

		// 2.- Llamo al Modelo para obtener datos

		// 3.- Llamo a la Vista
		response.sendRedirect("jsp/login.jsp");
	}

	private void verDashboard(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// 1.- Obtener datos que me envian en la solicitud
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("ctaUser");
		String nameUser = user.getUsername();
		session.setAttribute("nameUser", nameUser);
		// java.util.Date utilDate = new java.util.Date();

		// 2.- Llamo al Modelo para obtener datos
		// Date date = new Date(utilDate.getTime());
		List<Account> accounts = DAOFactory.getFactory().getAccountDAO().getAll();
		List<Category> categoriesSpent = DAOFactory.getFactory().getCategoryDAO().getCategoryList(Type.SPENT);
		List<Category> categoriesIncome = DAOFactory.getFactory().getCategoryDAO().getCategoryList(Type.INCOME);

		Double income = DAOFactory.getFactory().getMoveDAO().getBalanceByType(Type.INCOME);
		Double discharge = DAOFactory.getFactory().getMoveDAO().getBalanceByType(Type.SPENT);
		Double balance = income - discharge;

		request.setAttribute("categoriasG", categoriesSpent);
		request.setAttribute("categoriasI", categoriesIncome);
		request.setAttribute("cuentas", accounts);
		request.setAttribute("balance", balance);
		request.setAttribute("income", income);
		request.setAttribute("discharge", discharge);

		// 3.- Llamo a la Vista
		request.getRequestDispatcher("jsp/verDashboard.jsp").forward(request, response);
	}

//	y especificamente con este metodo nos ahorramos el logoutController, aplicando asi la teoria del ruteador
	private void salir(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.getSession().invalidate();
		response.sendRedirect("jsp/login.jsp");
	}

	
//	----------------------------------- VER MOVIMIENTOS ---------------------------------------------------
	private void verMovimientos(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// 1.- Obtener datos que me envï¿½an en la solicitud
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("ctaUser");
		String nameUser = user.getUsername();
		session.setAttribute("nameUser", nameUser);
		Date date = new Date(new java.util.Date().getTime()); // Inicializar con la fecha actual por defecto

		try {
			String fecha = request.getParameter("fecha");
			if (fecha != null && !fecha.isEmpty()) {
				date = Date.valueOf(fecha);
			}
		} catch (Exception e) {
			e.printStackTrace(); // Manejo de la excepción (puedes personalizarlo)
		}

		String fechaInicio = request.getParameter("fechaInicio");
		String fechaFin = request.getParameter("fechaFin");
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		Date startDate = null;
		Date endDate = null;
		try {
			if (fechaInicio == null || fechaFin == null) {
				Calendar calendar = Calendar.getInstance();
				calendar.set(Calendar.DAY_OF_MONTH, 1);
				startDate = new Date(calendar.getTime().getTime());
				calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
				endDate = new Date(calendar.getTime().getTime());
			} else {
				startDate = new Date(formatter.parse(fechaInicio).getTime());
				endDate = new Date(formatter.parse(fechaFin).getTime());				
			}

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 2.- Llamo al Modelo para obtener datos
		ArrayList<Move> movimientos = DAOFactory.getFactory().getMoveDAO().getAllMovebyUser(startDate, endDate, user);
		// 3.- Llamo a la Vista enviando datos
		request.setAttribute("accountName", "Todas las Cuentas");
		request.setAttribute("verTipo", "Todas");
		request.setAttribute("user", user);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("movimientos", movimientos);
		request.getRequestDispatcher("jsp/moves.jsp").forward(request, response);

	}

	private void verCuenta(HttpServletRequest request, HttpServletResponse response, int cuentaID)
			throws IOException, ServletException {
		// 1.- Obtener datos que me env�an en la solicitud
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("ctaUser");
		String nameUser = user.getUsername();
		session.setAttribute("nameUser", nameUser);
		Date date = new Date(new java.util.Date().getTime()); // Inicializar con la fecha actual por defecto

		try {
			String fecha = request.getParameter("fecha");
			if (fecha != null && !fecha.isEmpty()) {
				date = Date.valueOf(fecha);
			}
		} catch (Exception e) {
			e.printStackTrace(); // Manejo de la excepción (puedes personalizarlo)
		}

		// Este metodo me ayuda a obtener por Id una cuenta
		Account account = DAOFactory.getFactory().getAccountDAO().getById(cuentaID);
		String fechaInicio = request.getParameter("fechaInicio");
		String fechaFin = request.getParameter("fechaFin");
		System.out.println(account.getAccountName());
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		Date startDate = null;
		Date endDate = null;
		try {
			if (fechaInicio == null || fechaFin == null) {
				Calendar calendar = Calendar.getInstance();
				calendar.set(Calendar.DAY_OF_MONTH, 1);
				startDate = new Date(calendar.getTime().getTime());
				calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
				endDate = new Date(calendar.getTime().getTime());
			} else {
				startDate = new Date(formatter.parse(fechaInicio).getTime());
				endDate = new Date(formatter.parse(fechaFin).getTime());				
			}

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		// 2.- Llamo al Modelo para obtener datos
		ArrayList<Move> movimientos = DAOFactory.getFactory().getMoveDAO().filtrar(startDate,endDate, account);

		// 3.- Llamo a la Vista enviando datos
		request.setAttribute("user", user);
		request.setAttribute("cuentaID", cuentaID);
		request.setAttribute("verTipo", "Cuenta");
		request.setAttribute("accountName", account.getAccountName());
		request.setAttribute("movimientos", movimientos);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.getRequestDispatcher("jsp/moves.jsp").forward(request, response);
	}

	private void verCategoria(HttpServletRequest request, HttpServletResponse response, int catID)
			throws ServletException, IOException {
		// 1.- Obtener datos que me env�an en la solicitud
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("ctaUser");
		String nameUser = user.getUsername();
		session.setAttribute("nameUser", nameUser);
		Date date = new Date(new java.util.Date().getTime()); 

		try {
			String fecha = request.getParameter("fecha");
			if (fecha != null && !fecha.isEmpty()) {
				date = Date.valueOf(fecha);
			}
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		System.out.println("QuesyString" + request.getQueryString());
		Category category = DAOFactory.getFactory().getCategoryDAO().getById(catID);
		String fechaInicio = request.getParameter("fechaInicio");
		String fechaFin = request.getParameter("fechaFin");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		Date startDate = null;
		Date endDate = null;

		try {
			if (fechaInicio == null || fechaFin == null) {
				Calendar calendar = Calendar.getInstance();
				calendar.set(Calendar.DAY_OF_MONTH, 1);
				startDate = new Date(calendar.getTime().getTime());
				calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
				endDate = new Date(calendar.getTime().getTime());
			} else {
				startDate = new Date(formatter.parse(fechaInicio).getTime());
				endDate = new Date(formatter.parse(fechaFin).getTime());				
			}

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 2.- Llamo al Modelo para obtener datos
		ArrayList<Move> movimientos = DAOFactory.getFactory().getMoveDAO().filtrar(startDate,endDate, category);
		
		// 3.- Llamo a la Vista enviando datos
		request.setAttribute("user", user);
		request.setAttribute("catID", catID);
		request.setAttribute("verTipo", "Cat");
		request.setAttribute("accountName", category.getCategoryName());
		request.setAttribute("movimientos", movimientos);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.getRequestDispatcher("jsp/moves.jsp").forward(request, response);
	}

	private void eliminarMovimiento(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// 1.- Obtener datos que me env�an en la solicitud
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("ctaUser");
		String nameUser = user.getUsername();
		session.setAttribute("nameUser", nameUser);
		String verTipo = request.getParameter("verTipo");
		Integer moveId = Integer.parseInt(request.getParameter("movimientoId"));
		Double amount = Double.parseDouble(request.getParameter("amount"));
		Integer accountIdO = Integer.parseInt(request.getParameter("accountIdO"));
		Integer accountIdD = -1;
		Integer categoryId = Integer.parseInt(request.getParameter("categoryId"));
		try {
			accountIdD = Integer.parseInt(request.getParameter("accountIdD"));
		} catch (Exception e) {
			System.out.println("Id nulo");
		}

		// 2.- Llamo al Modelo para obtener datos
		DAOFactory.getFactory().getMoveDAO().deleteMove(moveId);
		Category category = DAOFactory.getFactory().getCategoryDAO().getById(categoryId);

		if (category.getType().equals(Type.INCOME)) {
			DAOFactory.getFactory().getCategoryDAO().updateValue(categoryId, -amount);
			DAOFactory.getFactory().getAccountDAO().updateBalance(accountIdO, -amount);
		} else if (category.getType().equals(Type.SPENT)) {
			DAOFactory.getFactory().getCategoryDAO().updateValue(categoryId, -amount);
			DAOFactory.getFactory().getAccountDAO().updateBalance(accountIdO, amount);
		} else if (category.getType().equals(Type.TRANSFER)) {
			DAOFactory.getFactory().getAccountDAO().updateBalance(accountIdO, amount);
			DAOFactory.getFactory().getAccountDAO().updateBalance(accountIdD, -amount);
		}

		System.out.println(verTipo);
		// 3.- Llamo a la Vista enviando datos
		if (verTipo.equals("Todas")) {
			request.getRequestDispatcher("ContabilidadController1?ruta=verMovimientos").forward(request, response);
		} else if (verTipo.equals("Cuenta")) {
			response.sendRedirect("ContabilidadController1?ruta=verCuenta&cuentaID=" + accountIdO);
		} else if (verTipo.equals("Cat")) {
			response.sendRedirect("ContabilidadController1?ruta=verCategoria&catID=" + categoryId);
		}
	}
}
