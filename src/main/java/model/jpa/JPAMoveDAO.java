package model.jpa;

import java.sql.Date;
import java.util.ArrayList;


import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

import model.DAO.MoveDAO;
import model.entidades.Account;
import model.entidades.Category;
import model.entidades.Move;
import model.entidades.Type;
import model.entidades.User;

public class JPAMoveDAO extends JPAGenericDAO<Move, Integer> implements MoveDAO{

	public JPAMoveDAO() {
		super(Move.class);
	}

	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<Move> getAllMovebyUser(Date startDate, Date endDate, User user) {
		String sentence = "SELECT m FROM Move m WHERE m.accountO IN (SELECT a FROM Account a WHERE a.user = :user) "
				+ "AND m.date BETWEEN :startDate AND :endDate";

		Query query = em.createQuery(sentence);
		query.setParameter("user", user);
		query.setParameter("startDate", startDate);
		query.setParameter("endDate", endDate);

		return new ArrayList<>(query.getResultList());
	}

	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<Move> filtrar(Date startDate,Date endDate, Account account) {
		String sentence = "SELECT m FROM Move m WHERE m.accountO = :account "
				+ "AND m.date BETWEEN :startDate AND :endDate";
		
		Query query = em.createQuery(sentence);
		query.setParameter("account", account);
		query.setParameter("startDate", startDate);
		query.setParameter("endDate", endDate);


		return new ArrayList<>(query.getResultList());
	}

	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<Move> filtrar(Date startDate,Date endDate, Category category) {
		String sentence = "SELECT m FROM Move m WHERE m.category = :category "
				+ "AND m.date BETWEEN :startDate AND :endDate";

		Query query = em.createQuery(sentence);
		query.setParameter("category", category);
		query.setParameter("startDate", startDate);
		query.setParameter("endDate", endDate);

		return new ArrayList<>(query.getResultList());
	}

	@Override
	public void insertMove(Move move) {
		em.getTransaction().begin();
		em.persist(move);
		em.getTransaction().commit();
	}
	
	@Override
	public void deleteMove(int id) {		
		Move moveSearched = em.find(Move.class, id);
		em.getTransaction().begin();		
		em.remove(moveSearched);
		em.getTransaction().commit();
	}
	
	@Override
	public Double getBalanceByType(Type categoryType) {
        try {
            String jpql = "SELECT SUM(m.amount) FROM Move m " +
                          "WHERE m.category.type = :categoryType";

            TypedQuery<Double> query = em.createQuery(jpql, Double.class);
            query.setParameter("categoryType", categoryType);

            Double income = query.getSingleResult();

            return income != null ? income : 0.0;
        } finally {
            em.close();
        }
	}

}
