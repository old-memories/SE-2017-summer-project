package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import model.ExchangeProfile;
import service.ExchangeService;
import service.UserService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zzy on 2017/7/20.
 */
public class ExchangeAction extends ActionSupport{
    private ExchangeService exchangeService;
    private UserService userService;
    private int wantedBookID;
    private int hadBookID;
    private String address;  //���뽻���ߵ�ַ
    private Map params;
    private int exchangeID;
    private String address2;
    private String trackingNo1;
    private String trackingNo2;
    private int comment1;
    private int comment2;

    /*======================================================*/
    public void setExchangeService(ExchangeService exchangeService){
        this.exchangeService=exchangeService;
    }

    public ExchangeService getExchangeService(){
        return this.exchangeService;
    }
    public void setUserService(UserService userService) {
        this.userService = userService;
    }
    public UserService getUserService(){
        return this.userService;
    }
    public void setWantedBookID(int wantedBookID) {
        this.wantedBookID = wantedBookID;
    }
    public int getWantedBookID(){
        return this.wantedBookID;
    }
    public int getHadBookID() {
        return hadBookID;
    }
    public void setHadBookID(int hadBookID) {
        this.hadBookID = hadBookID;
    }
    public Map getParams() {
        return params;
    }

    public void setParams(Map params) {
        this.params = params;
    }
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    public int getExchangeID(){return this.exchangeID;}
    public void setExchangeID(int exchangeID){this.exchangeID = exchangeID;}
    public String getAddress2() {
        return address2;
    }
    public void setAddress2(String address2) {
        this.address2 = address2;
    }
    public String getTrackingNo1() {
        return trackingNo1;
    }

    public void setTrackingNo1(String trackingNo1) {
        this.trackingNo1 = trackingNo1;
    }

    public String getTrackingNo2() {
        return trackingNo2;
    }

    public void setTrackingNo2(String trackingNo2) {
        this.trackingNo2 = trackingNo2;
    }

    public int getComment1() {
        return comment1;
    }

    public void setComment1(int comment1) {
        this.comment1 = comment1;
    }

    public int getComment2() {
        return comment2;
    }

    public void setComment2(int comment2) {
        this.comment2 = comment2;
    }
    /*======================================================*/
    public String prepareExchange(){
        Map prepareExchangeInfo = this.exchangeService.prepareExchange(this.wantedBookID);
        Map deliveryAddressInfo = this.userService.getAllDeliveryAddress();
        ActionContext.getContext().put("wantedBook",prepareExchangeInfo.get("wantedBook"));
        ActionContext.getContext().put("userReleasedBookList",prepareExchangeInfo.get("userReleasedBookList"));
        ActionContext.getContext().put("defaultAddrList", deliveryAddressInfo.get("defaultAddrList"));
        ActionContext.getContext().put("addrList", deliveryAddressInfo.get("addrList"));
        return "showExchangeApply";
    }

    public String createExchangeOrder(){
        this.params=new HashMap();
        this.params.put("success",this.exchangeService.applyExchange(wantedBookID,hadBookID,address));
        return "ajax";
    }

    public String showMyExchange(){
        Map result = this.exchangeService.showMyExchange();
        List<ExchangeProfile> activeExchange = (List<ExchangeProfile>) result.get("activeExchange");
        List<ExchangeProfile> activeExchangeHistory = (List<ExchangeProfile>) result.get("activeExchangeHistory");
        List<ExchangeProfile> passiveExchange = (List<ExchangeProfile>) result.get("passiveExchange");
        List<ExchangeProfile> passiveExchangeHistory = (List<ExchangeProfile>) result.get("passiveExchangeHistory");
        System.out.println(passiveExchange.size()+"^&*");

        ActionContext.getContext().put("activeExchange",activeExchange);
        ActionContext.getContext().put("activeExchangeHistory",activeExchangeHistory);
        ActionContext.getContext().put("passiveExchange",passiveExchange);
        ActionContext.getContext().put("passiveExchangeHistory",passiveExchangeHistory);
        return "showMyExchange";
    }

    public String rejectExchange(){
        if(this.exchangeService.rejectExchange(exchangeID)){
            return "redirectToShowMyExchange";
        }
        return null;
    }

    public String agreeExchange(){
        if(this.exchangeService.agreeExchange(exchangeID,address2)){
            return "redirectToShowMyExchange";
        }
        return null;
    }

    public String cancelExchange(){
        if(this.exchangeService.cancelExchange(exchangeID)){
            return "redirectToShowMyExchange";
        }
        return null;
    }

    public String fh2(){
        if(this.exchangeService.fh2(exchangeID,trackingNo2)){
            return "redirectToShowMyExchange";
        }
        return null;
    }

    public String sh2(){
        if(this.exchangeService.sh2(exchangeID)){
            return "redirectToShowMyExchange";
        }
        return null;
    }

    public String fh1(){
        if(this.exchangeService.fh1(exchangeID,trackingNo1)){
            return "redirectToShowMyExchange";
        }
        return null;
    }

    public String sh1(){
        if(this.exchangeService.sh1(exchangeID)){
            return "redirectToShowMyExchange";
        }
        return null;
    }

    /*
    public String comment1(){
        if(this.exchangeService.comment1(exchangeID,comment1)){
            return "comment1";
        }
        return null;
    }

    public String comment2(){
        if(this.exchangeService.comment2(exchangeID,comment2)){
            return "comment2";
        }
        return null;
    }
    */





}
