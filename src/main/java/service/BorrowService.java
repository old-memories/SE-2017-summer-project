package service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import model.Book;
import model.BorrowProfile;

public interface BorrowService extends BaseService {
    public Map showMyBorrow();
    /*
    public boolean borrowBook(int bookID);
    */
    public Map createBorrowOrder(String fullAddress);
    public Map confirmBorrowOrder(List<Integer> borrowIDList);
    public Map returnBook(int borrowID,String trackingNo1);
    public Map delayBook(int borrowID);
    public Map confirmBorrowReceipt(int borrowID);
    public boolean cancelBorrowOrder(int borrowID);
    
    public List<BorrowProfile> getLendBookList();
    public List<BorrowProfile> getLendBookHistoryList();
    public Map deliveryBorrowOrder(int borrowID,String trackingNo2,String returnAddress);
    public Map confirmReturnReceipt(int borrowID);
}