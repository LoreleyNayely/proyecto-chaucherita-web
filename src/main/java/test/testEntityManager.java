package test;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import model.DAO.DAOFactory;
import model.entidades.Account;
import model.entidades.Category;
import model.entidades.Type;
import model.entidades.User;


public class testEntityManager {

	public static void main(String[] args) {
		
		insertarCategorias();
		insertarCuentas();
		insertarUsuarios();

		
	}


	private static void insertarUsuarios() {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpaMiChaucherita");
		EntityManager em = emf.createEntityManager();
		
		List<Account> accounts = DAOFactory.getFactory().getAccountDAO().getAll();
//		tener la entity a insertar
		User p1 = new User("Lore","1", accounts);
		User p2 = new User("Pazmino","2", accounts);
		
		
//		INSERTAR
		em.getTransaction().begin();
		em.persist(p1);
		em.persist(p2);
		
		em.getTransaction().commit();
		
	}
	private static void insertarCuentas() {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpaMiChaucherita");
		EntityManager em = emf.createEntityManager();
	
		
//		tener la entity a insertar
		Account account1 = new Account("Banco Pichincha", 0.0);
		Account account2 = new Account("Banco Pichincha Ahorro", 0.0);
		Account account3 = new Account("Efectivo", 0.0);

		
//		INSERTAR
		em.getTransaction().begin();
		em.persist(account1);
		em.persist(account2);
		em.persist(account3);
		em.getTransaction().commit();
		
	}
	
	private static void insertarCategorias() {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpaMiChaucherita");
		EntityManager em = emf.createEntityManager();
		
//		tener la entity a insertar
		Category cat1 = new Category("Alimentación", 0.0, Type.SPENT);
		Category cat2 = new Category("Salud", 0.0, Type.SPENT);
		Category cat3 = new Category("Vivienda", 0.0, Type.SPENT);
		Category cat4 = new Category("Transporte", 0.0, Type.SPENT);
		Category cat5 = new Category("Vestimenta", 0.0, Type.SPENT);
		
		Category cat6 = new Category("Ahorros", 0.0, Type.INCOME);
		Category cat7 = new Category("Deposito", 0.0, Type.INCOME);
		Category cat8 = new Category("Salario", 0.0, Type.INCOME);
		
		Category cat9 = new Category("Transferencia", 0.0, Type.TRANSFER);
		
//		INSERTAR
		em.getTransaction().begin();
		em.persist(cat1);
		em.persist(cat2);
		em.persist(cat3);
		em.persist(cat4);
		em.persist(cat5);
		em.persist(cat6);
		em.persist(cat7);
		em.persist(cat8);
		em.persist(cat9);
		em.getTransaction().commit();
		
	}

}