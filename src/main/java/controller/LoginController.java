package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAO.DAOFactory;
import model.entidades.User;


/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginController() {
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
//	El enrutador siempre tiene como parametros el request y response
	private void ruteador(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String ruta = (request.getParameter("ruta") == null) ? "inicio" : request.getParameter("ruta");

		switch (ruta) {
		case "inicio":
			this.inicio(request, response);
			break;
		case "ingresar":
			this.ingresar(request, response);
			break;
		case "salir":
			this.salir(request, response);
			break;
	
		default:
			break;
		}
	}
	

	private void inicio(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 1.- Obtener datos que me env�an en la solicitud
		// 2.- Llamo al Modelo para obtener datos
		// 3.- Llamo a la Vista
		response.sendRedirect("jsp/login.jsp");
	}
	
//	y especificamente con este metodo nos ahorramos el logoutController, aplicando asi la teoria del ruteador
	private void salir(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.getSession().invalidate();
		response.sendRedirect("jsp/login.jsp");
	}
	
//	si nos damos cuenta en esta seccion entraria lo que teniamos en el codigo doPost
	private void ingresar(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// 1.- Obtener datos que me envian en la solicitud

		String ctausuario = request.getParameter("usuario");
		String clave = request.getParameter("password");

		// 2.- Llamo al Modelo para obtener datos

		User authUser = DAOFactory.getFactory().getUserDAO().autorizar(ctausuario, clave);
		
		if (authUser == null) {
			response.sendRedirect("jsp/login.jsp");

			
		}else {
			// Crear la Sesion
						HttpSession session = request.getSession();
						session.setAttribute("ctaUser", authUser);
						
						DAOFactory.getFactory().getAccountDAO().actualizarUsuarioCuentas(authUser);
						
						// 3. Llamo a la Vista
						response.sendRedirect("ContabilidadController1?ruta=verDashboard");
						
		}
		
	}
	
	/*private void error(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException{
		// 1.- Obtener datos que me envian en la solicitud

		String ctausuario = request.getParameter("usuario");
		String clave = request.getParameter("password");

		// 2.- Llamo al Modelo para obtener datos

		User authUser = DAOFactory.getFactory().getUserDAO().autorizar(ctausuario, clave);
		
		if (authUser != null) {
			
			// Crear la Sesion
			HttpSession session = request.getSession();
			session.setAttribute("ctaUser", authUser);
			
			DAOFactory.getFactory().getAccountDAO().actualizarUsuarioCuentas(authUser);
			
			// 3. Llamo a la Vista
			response.sendRedirect("ContabilidadController1?ruta=verDashboard");
			return;
		}else {
			// 3. Redireccionar a la Vista
			request.getRequestDispatcher("jsp/error.jsp").forward(request, response);
		}
	}
	*/
}