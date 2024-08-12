package resources;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;

import model.DAO.DAOFactory;
import model.entidades.User;

@Path("/user")
public class UserResource {
	@GET
	@Path("/byId")
	@Produces(MediaType.APPLICATION_JSON)
	public User getById(@QueryParam("id") int id) {
		return DAOFactory.getFactory().getUserDAO().getById(id);
	}
}
