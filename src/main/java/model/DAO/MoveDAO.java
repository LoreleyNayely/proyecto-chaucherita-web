package model.DAO;


import java.sql.Date;
import java.util.ArrayList;

import model.entidades.Account;
import model.entidades.Category;
import model.entidades.Move;
import model.entidades.Type;
import model.entidades.User;

public interface MoveDAO {
	public ArrayList<Move> getAllMovebyUser(Date startDate, Date endDate, User user);
	public ArrayList<Move> filtrar(Date startDate, Date endDate, Account account);
	public ArrayList<Move> filtrar(Date startDate,Date endDate, Category category);
	public void insertMove(Move move);
	public void deleteMove(int id);
	public Double getBalanceByType(Type categoryType);
}
