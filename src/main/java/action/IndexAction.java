package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import service.BookService;

/**
 * Created by zzy on 2017/7/4.
 */
public class IndexAction extends ActionSupport {
    private BookService bookService;
    public BookService getBookService() {
        return bookService;
    }
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }
    public String index() {
        ActionContext.getContext().put("title","ͼ�������ƽ̨");
        return "showIndex";
    }
}
