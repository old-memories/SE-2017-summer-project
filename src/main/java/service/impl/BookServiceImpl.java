package service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import common.cache.AllBookCategory;
import common.constants.BookStatus;
import dao.BookDao;
import dao.BookReleaseDao;
import dao.CategoryDao;
import dao.ImageDao;
import model.Book;
import model.BookProfile;
import model.BookRelease;
import model.Category1;
import service.BookService;

public class BookServiceImpl extends BaseServiceImpl implements BookService {
    private BookDao bookDao;
    private CategoryDao categoryDao;
    private BookReleaseDao bookReleaseDao;
    private ImageDao imageDao;
    
    /* ===================================================== */
    
    public BookDao getBookDao() {
        return bookDao;
    }

    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }   
    
    
    public CategoryDao getCategoryDao() {
        return categoryDao;
    }

    public void setCategoryDao(CategoryDao categoryDao) {
        this.categoryDao = categoryDao;
    }

    public BookReleaseDao getBookReleaseDao() {
        return bookReleaseDao;
    }

    public void setBookReleaseDao(BookReleaseDao bookReleaseDao) {
        this.bookReleaseDao = bookReleaseDao;
    }

    public ImageDao getImageDao() {
        return imageDao;
    }

    public void setImageDao(ImageDao imageDao) {
        this.imageDao = imageDao;
    }

    /* ===================================================== */

    @Override
    public Boolean uploadBook(BookProfile bookProfile) {
        if(!isLogined()) {
            return false;
        }
        Map bookProfileInMongo = new HashMap();
//        bookProfileInMongo.put("category2", bookProfile.getCategory2());
        // bookProfileInMongo.put("publish", new HashMap(){{put("year",publishYear);put("month",publishMonth);}});
        // bookProfileInMongo.put("edtion", new HashMap(){{put("year",edtionYear);put("month",edtionMonth);put("version",edtionVersion);}});
        bookProfileInMongo.put("editionYear", bookProfile.getEditionYear());
        bookProfileInMongo.put("editionMonth", bookProfile.getEditionMonth());
        bookProfileInMongo.put("editionVersion", bookProfile.getEditionVersion());
        bookProfileInMongo.put("page", bookProfile.getPage());
        bookProfileInMongo.put("bookBinding", bookProfile.getBookBinding());
        bookProfileInMongo.put("bookFormat", bookProfile.getBookFormat());
        bookProfileInMongo.put("bookQuality", bookProfile.getBookQuality());
        bookProfileInMongo.put("bookDamage", bookProfile.getBookDamage());
        bookProfileInMongo.put("intro", bookProfile.getIntro());
        if(bookProfile.getOtherPicture() != null) {
            List otherPictureID = new ArrayList();
            for(File tmp : bookProfile.getOtherPicture()) {
                // save otherPicture
                otherPictureID.add(this.imageDao.saveImage(tmp));
            }
            bookProfileInMongo.put("otherPictureID", otherPictureID);
        }
        
        Book newBook = new Book();
        newBook.setBookName(bookProfile.getBookName());
        newBook.setIsbn(bookProfile.getIsbn());
        newBook.setAuthor(bookProfile.getAuthor());
        newBook.setPress(bookProfile.getPress());
        newBook.setCategory1(bookProfile.getCategory1());
        newBook.setCategory2(bookProfile.getCategory2());
        newBook.setPublishYear(bookProfile.getPublishYear());
        newBook.setPublishMonth(bookProfile.getPublishMonth());;
        newBook.setCanBorrow(bookProfile.getCanBorrow());
        newBook.setCanExchange(bookProfile.getCanExchange());
        newBook.setBorrowCredit(bookProfile.getBorrowCredit());
        newBook.setBuyCredit(bookProfile.getBuyCredit());
        newBook.setReserved(0);
        newBook.setStatus(BookStatus.IDLE);
        
        // saveBookProfile
        newBook.setProfileID(this.bookDao.saveBookProfileInMongo(bookProfileInMongo));
        if(bookProfile.getCoverPicture() != null) {
            // save coverPicture
            newBook.setImageID(this.imageDao.saveImage(bookProfile.getCoverPicture()));
        }
        else {
            newBook.setImageID("");
        }
        this.bookDao.save(newBook);
        
        BookRelease newBookRelease = new BookRelease();
        newBookRelease.setBookID(newBook.getBookID());
        newBookRelease.setReleaseTime(new Date());
        newBookRelease.setUserID(getLoginedUserInfo().getUserID());
        this.bookReleaseDao.save(newBookRelease);
        
        return true;
    }

    @Override
    public List<Book> showAllBooksByPage(int part,int pageSize) {
        return this.bookDao.getAllBooksByPage(part, pageSize);
    }

    @Override
    public List<Book> showUserBooks(int userID) {
        return this.bookDao.getBooksByUserID(userID);
    }

    @Override
    public List<Book> searchByTextByPage(String searchText,int part,int pageSize) {
        return this.bookDao.searchByTextByPage(searchText,part,pageSize);
    }
    
    @Override
    public List<Book> searchBook(Map condition) {
        // TODO 自动生成的方法存根
        return null;
    }

    public Book showBook(int bookID) {
        return this.bookDao.getBookByID(bookID);
    }
    
    @Override
    public BookProfile showBookProfile(int bookID) {
        // 这里的返回值不仅包括mongodb中的内容，也包括mysql中的内容
        Book book = this.bookDao.getBookByID(bookID);
        BookRelease bookRelease = this.bookReleaseDao.getReleaseBookByBookID(bookID);
        Map bookProfileInMongo = this.bookDao.getBookProfileMapInMongo(book);
        BookProfile bookProfile = new BookProfile();
        
        bookProfile.setBookID(book.getBookID());
        bookProfile.setBookName(book.getBookName());
        bookProfile.setIsbn(book.getIsbn());
        bookProfile.setAuthor(book.getAuthor());
        bookProfile.setPress(book.getPress());
        bookProfile.setCategory1(book.getCategory1());
        bookProfile.setCategory2(book.getCategory2());
        bookProfile.setPublishYear(book.getPublishYear());
        bookProfile.setPublishMonth(book.getPublishMonth());
        bookProfile.setCanExchange(book.getCanExchange());
        bookProfile.setCanBorrow(book.getCanBorrow());
        bookProfile.setReserved(book.getReserved());
        bookProfile.setStatus(book.getStatus());
        bookProfile.setBookStatus(book.getStatus().toString());
        bookProfile.setImageID(book.getImageID());
        
        bookProfile.setBorrowCredit(book.getBorrowCredit());
        bookProfile.setBuyCredit(book.getBuyCredit());
        bookProfile.setReleaseTime(bookRelease.getReleaseTime());
        
        bookProfile.setEditionYear((int)bookProfileInMongo.get("editionYear"));
        bookProfile.setEditionMonth((int)bookProfileInMongo.get("editionMonth"));
        bookProfile.setEditionVersion((int)bookProfileInMongo.get("editionVersion"));
        bookProfile.setPage((int)bookProfileInMongo.get("page"));
        bookProfile.setBookBinding((String)bookProfileInMongo.get("bookBinding"));
        bookProfile.setBookFormat((String)bookProfileInMongo.get("bookFormat"));
        bookProfile.setBookQuality((String)bookProfileInMongo.get("bookQuality"));
        bookProfile.setBookDamage((String)bookProfileInMongo.get("bookDamage"));
        bookProfile.setIntro((String)bookProfileInMongo.get("intro"));
        bookProfile.setOtherPictureIDList((List<String>)bookProfileInMongo.get("otherPictureID"));

        return bookProfile;
    }
    
    @Override
    public List<Book> showBooksByCategory1NameByPage(String category1Name, int part, int pageSize) {
        return this.bookDao.getBooksByCategory1NameByPage(category1Name, part, pageSize);
    }
    
    @Override
    public List<Book> showBooksByCategory2NameByPage(String category2Name, int part, int pageSize) {
        return this.bookDao.getBooksByCategory2NameByPage(category2Name, part, pageSize);
    }
    
    @Override
    public List<Category1> showAllCategory1s() {
        if(AllBookCategory.getAllBookCategory()==null) {
            AllBookCategory.setAllBookCategory(this.categoryDao.getAllCategory());
        }
        return AllBookCategory.getAllBookCategory();
    }
    
    @Override
    public List<Book> showBooksByConditions(Integer part, Integer pageSize, String category1Name, String category2Name) {
        Map conditions = new HashMap();
        if(part != null && pageSize != null) {
            conditions.put("part", part);
            conditions.put("pageSize", pageSize);
        }
        if(category1Name != null) {
            conditions.put("category1Name", category1Name);
        }
        if(category2Name != null) {
            conditions.put("category2Name", category2Name);
        }
        List<Book> result = this.bookDao.searchByCondition(conditions);
        return result;
    }
}