package model;

import common.constants.BookStatus;

public class Book {
    private int bookID;
    private String bookName;
    private String isbn;
    private String author;            // 作者
    private String press;             // 出版社
    private String category1;
    private String category2;
    private int publishYear;
    private int publishMonth;
    private int canExchange;      // 用户发布时决定书是否可被交换
    private int canBorrow;        // 用户发布时决定书是否可被借阅
    private int reserved;         // 书当前是否已被预约 
    private int borrowCredit;           // 设定借书需要的积分
    private int buyCredit;         // 设定购买书需要的积分
    private BookStatus status;               // 书当前状态（空闲/正被借阅/正被交换/正被售出（尚未考虑））
    private String bookStatus;           // 书当前状态（字符串）
    private String profileID;         // 书的详细信息在monggodb中的id
    private String imageID;           // 书的图片在monggodb中的图片
    
    /* ============================================================== */
    
    public int getBookID() {
        return bookID;
    }
    public void setBookID(int bookID) {
        this.bookID = bookID;
    }
    public String getBookName() {
        return bookName;
    }
    public void setBookName(String bookName) {
        this.bookName = bookName;
    }
    public String getIsbn() {
        return isbn;
    }
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }
    public String getPress() {
        return press;
    }
    public void setPress(String press) {
        this.press = press;
    }
    
    public String getCategory1() {
		return category1;
	}
	public void setCategory1(String category1) {
		this.category1 = category1;
	}
	public String getCategory2() {
		return category2;
	}
	public void setCategory2(String category2) {
		this.category2 = category2;
	}
	public int getPublishYear() {
        return publishYear;
    }
    public void setPublishYear(int publishYear) {
        this.publishYear = publishYear;
    }
    public int getPublishMonth() {
        return publishMonth;
    }
    public void setPublishMonth(int publishMonth) {
        this.publishMonth = publishMonth;
    }
    public int getCanExchange() {
        return canExchange;
    }
    public void setCanExchange(int canExchange) {
        this.canExchange = canExchange;
    }
    public int getCanBorrow() {
        return canBorrow;
    }
    public void setCanBorrow(int canBorrow) {
        this.canBorrow = canBorrow;
    }
    public int getReserved() {
        return reserved;
    }
    public void setReserved(int reserved) {
        this.reserved = reserved;
    }
   
	/**
	 * @return the borrowCredit
	 */
	public int getBorrowCredit() {
		return borrowCredit;
	}
	/**
	 * @param borrowCredit the borrowCredit to set
	 */
	public void setBorrowCredit(int borrowCredit) {
		this.borrowCredit = borrowCredit;
	}
	/**
	 * @return the buyCredit
	 */
	public int getBuyCredit() {
		return buyCredit;
	}
	/**
	 * @param buyCredit the buyCredit to set
	 */
	public void setBuyCredit(int buyCredit) {
		this.buyCredit = buyCredit;
	}
	public BookStatus getStatus() {
        return status;
    }
    public void setStatus(BookStatus status) {
        this.status = status;
    }
    public String getBookStatus() {
        return bookStatus;
    }
    public void setBookStatus(String bookStatus) {
        this.bookStatus = bookStatus;
    }
    public String getProfileID() {
        return profileID;
    }
    public void setProfileID(String profileID) {
        this.profileID = profileID;
    }
    public String getImageID() {
        return imageID;
    }
    public void setImageID(String imageID) {
        this.imageID = imageID;
    }
    
}
