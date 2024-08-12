package resources;

import java.util.List;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;

import model.DAO.DAOFactory;
import model.entidades.Account;

@Path("/account")
public class AccountResource {
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Account> getAll() {
		return DAOFactory.getFactory().getAccountDAO().getAll();
	}
	
	@GET
	@Path("/byId")
	@Produces(MediaType.APPLICATION_JSON)
	public Account getById(@QueryParam("id") int id) {
		return DAOFactory.getFactory().getAccountDAO().getById(id);
	}
	
	@PUT
	@Path("/updateBalance")
	@Produces(MediaType.TEXT_PLAIN)
	@Consumes(MediaType.APPLICATION_JSON)
	public void updateBalance(@QueryParam("id") int id, @QueryParam("amount") double amount) {
		DAOFactory.getFactory().getAccountDAO().updateBalance(id, amount);
	}
}
