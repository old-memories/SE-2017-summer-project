package model;

import java.io.File;
import java.util.Date;
import java.util.List;

import common.constants.BookStatus;

public class BookProfile {
    private int bookID;
    private String bookName;
    private String isbn;
    private String author;            // 作者
    private String press;             // 出版社
    private String category1;
    private String category2;
    private int canExchange;      // 用户发布时决定书是否可被交换
    private int canBorrow;        // 用户发布时决定书是否可被借阅
    private int reserved;         // 书当前是否已被预约 
    private BookStatus status;               // 书当前状态（空闲/正被借阅/正被交换/正被售出（尚未考虑））
    private String bookStatus;     // 书当前状态（字符串形式，用于前端）
    private String profileID;         // 书的详细信息在monggodb中的id
    private String imageID;           // 书的图片在monggodb中的图片
    /* ============ */
    private int borrowCredit;           // 设定借书需要的积分
    private int buyCredit;         // 设定购买书需要的积分
    private Date releaseTime;      // 发布时间
    /* ============ */
    private int publishYear;
    private int publishMonth;
    private int editionYear;
    private int editionMonth;
    private int editionVersion;
    private int page;
    private String bookBinding;
    private String bookFormat;
    private String bookQuality;
    private String bookDamage;
    private String intro;
    private List<String> otherPictureIDList;
    /* ============ */
    private File coverPicture;
    private String coverPictureFileName;
    private String coverPictureContentType;
    private File[] otherPicture;
    private String[] otherPictureFileName;
    private String[] otherPictureContentType;
    
    /* ==================================================== */
    
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
    public int getBorrowCredit() {
        return borrowCredit;
    }
    public void setBorrowCredit(int borrowCredit) {
        this.borrowCredit = borrowCredit;
    }
    public int getBuyCredit() {
        return buyCredit;
    }
    public void setBuyCredit(int buyCredit) {
        this.buyCredit = buyCredit;
    }
    public Date getReleaseTime() {
        return releaseTime;
    }
    public void setReleaseTime(Date releaseTime) {
        this.releaseTime = releaseTime;
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
    public int getEditionYear() {
        return editionYear;
    }
    public void setEditionYear(int editionYear) {
        this.editionYear = editionYear;
    }
    public int getEditionMonth() {
        return editionMonth;
    }
    public void setEditionMonth(int editionMonth) {
        this.editionMonth = editionMonth;
    }
    public int getEditionVersion() {
        return editionVersion;
    }
    public void setEditionVersion(int editionVersion) {
        this.editionVersion = editionVersion;
    }
    public int getPage() {
        return page;
    }
    public void setPage(int page) {
        this.page = page;
    }
    public String getBookBinding() {
        return bookBinding;
    }
    public void setBookBinding(String bookBinding) {
        this.bookBinding = bookBinding;
    }
    public String getBookFormat() {
        return bookFormat;
    }
    public void setBookFormat(String bookFormat) {
        this.bookFormat = bookFormat;
    }
    public String getBookQuality() {
        return bookQuality;
    }
    public void setBookQuality(String bookQuality) {
        this.bookQuality = bookQuality;
    }
    public String getBookDamage() {
        return bookDamage;
    }
    public void setBookDamage(String bookDamage) {
        this.bookDamage = bookDamage;
    }
    public String getIntro() {
        return intro;
    }
    public void setIntro(String intro) {
        this.intro = intro;
    }
    public List<String> getOtherPictureIDList() {
        return otherPictureIDList;
    }
    public void setOtherPictureIDList(List<String> otherPictureIDList) {
        this.otherPictureIDList = otherPictureIDList;
    }
    public File getCoverPicture() {
        return coverPicture;
    }
    public void setCoverPicture(File coverPicture) {
        this.coverPicture = coverPicture;
    }
    public File[] getOtherPicture() {
        return otherPicture;
    }
    public void setOtherPicture(File[] otherPicture) {
        this.otherPicture = otherPicture;
    }
}