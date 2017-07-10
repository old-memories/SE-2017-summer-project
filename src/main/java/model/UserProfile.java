package model;

import java.util.List;

public class UserProfile {
    private int userID;
    private String nickName;
    private String plainPassword;   // 明文密码
    private String password;        // 加密后的密码
    private String email;
    private int credit;
    private String imageID;
    private String province;        // 用户地址，区别于收货地址
    private String city;
    private String district;
    private String address;
    
    private String name;
    private String gender;
    private String mobile;
    private List<FullAddress> deliveryAddress;     // 收货地址
    
    /* ======================================================== */
    
    public int getUserID() {
        return userID;
    }
    public void setUserID(int userID) {
        this.userID = userID;
    }
    public String getNickName() {
        return nickName;
    }
    public void setNickName(String nickName) {
        this.nickName = nickName;
    }
    public String getPlainPassword() {
        return plainPassword;
    }
    public void setPlainPassword(String plainPassword) {
        this.plainPassword = plainPassword;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public int getCredit() {
        return credit;
    }
    public void setCredit(int credit) {
        this.credit = credit;
    }
    public String getImageID() {
        return imageID;
    }
    public void setImageID(String imageID) {
        this.imageID = imageID;
    }
    public String getProvince() {
        return province;
    }
    public void setProvince(String province) {
        this.province = province;
    }
    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }
    public String getDistrict() {
        return district;
    }
    public void setDistrict(String district) {
        this.district = district;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }
    public String getMobile() {
        return mobile;
    }
    public void setMobile(String mobile) {
        this.mobile = mobile;
    }
    public List<FullAddress> getDeliveryAddress() {
        return deliveryAddress;
    }
    public void setDeliveryAddress(List<FullAddress> deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }
    
    
}