package service.impl;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;

import com.opensymphony.xwork2.ActionContext;

import common.constants.UserRole;
import common.constants.UserStatus;
import common.utils.MD5Util;
import common.utils.PasswordUtil;
import common.utils.SendEmail;
import dao.ImageDao;
import dao.UserDao;
import model.FullAddress;
import model.User;
import model.UserProfile;
import service.UserService;

public class UserServiceImpl extends BaseServiceImpl implements UserService {
    private UserDao userDao; 
    private ImageDao imageDao;
    
    /* ======================================================== */

    public UserDao getUserDao() {
        return userDao;
    }
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }
    public ImageDao getImageDao() {
        return imageDao;
    }
    public void setImageDao(ImageDao imageDao) {
        this.imageDao = imageDao;
    }
    
    /* ======================================================== */

    @Override
    public Map login(String email, String plainPassword) {
        Boolean logined = isLogined();
        if(!logined) {
            if(email != null) {
                User userinfo = getUserDao().getUserByEmail(email);
                if(userinfo != null) {
                    if(PasswordUtil.checkPassword(plainPassword, userinfo.getPassword())) {
                        if(userinfo.getStatus() == UserStatus.ACTIVATED) {
                            setLoginedUserInfo(userinfo);
                            logined = true;
                        }
                    }
                }
            }
        }
        
        User userinfo = getLoginedUserInfo();
        Map params = new HashMap();
        if(logined) {
            params.put("result", true);
            params.put("message", "登录成功");
            params.put("userID", userinfo.getUserID());
            params.put("email", userinfo.getEmail());
            params.put("role", (userinfo.getRole()==UserRole.ADMIN)? 0:1);
        }
        else {
            params.put("result", false);
            params.put("message", "用户名或密码错误");
        }
        return params;
    }

    @Override
    public boolean register(UserProfile registerInfo) {
        String email = registerInfo.getEmail();
        if(this.userDao.getUserByEmail(email) != null) {
            return false;
        }
        User newUser = new User();
        Map userProfile = new HashMap();
        
        userProfile.put("name", registerInfo.getName());
        userProfile.put("gender", registerInfo.getGender());
        userProfile.put("mobile", registerInfo.getMobile());
        userProfile.put("deliveryAddress", new ArrayList());
        
        String profileID = this.userDao.saveUserProfileInMongo(userProfile);
        newUser.setProfileID(profileID);
        newUser.setEmail(email);
        newUser.setNickName(registerInfo.getNickName());
        newUser.setPassword(PasswordUtil.getEncryptedPassword(registerInfo.getPlainPassword()));
        newUser.setRole(UserRole.COMMON);
        newUser.setCredit(0);
        newUser.setProvince(registerInfo.getProvince());
        newUser.setCity(registerInfo.getCity()!=null?registerInfo.getCity():"请选择");
        newUser.setDistrict(registerInfo.getDistrict()!=null?registerInfo.getDistrict():"请选择");
        newUser.setAddress(registerInfo.getAddress());
        newUser.setImageID("");

        newUser.setStatus(UserStatus.UNACTIVATED);  //设置未激活
        Date currentDate = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(currentDate);
        calendar.add(Calendar.DATE, 1);
        Date due = calendar.getTime();
        newUser.setDue(due);  //设置激活due
        newUser.setActiveCode(MD5Util.encoderByMd5(email+currentDate)); //设置激活码

        
        this.userDao.save(newUser);

        //发送验证邮件
        String encodedEmail = new String(email);
        try {
            encodedEmail = URLEncoder.encode(email, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        }
        StringBuffer sb=new StringBuffer("点击下面链接激活账号，24小时生效，否则重新注册账号，链接只能使用一次，请尽快激活！</br>");
        //sb.append("<a href=\"http://localhost:8080/bookshare/authAction/activate.action?email=");
        sb.append("<a href=\"");
        sb.append(this.getBasePath());
        sb.append("/authAction/activate.action?email=");
        sb.append(encodedEmail);
        sb.append("&activeCode=");
        sb.append(newUser.getActiveCode());
        //sb.append("\">http://localhost:8080/bookshare/authAction/activate.action?email=");
        sb.append("\">");
        sb.append(this.getBasePath());
        sb.append("/authAction/activate.action?email=");
        sb.append(encodedEmail);
        sb.append("&activeCode=");
        sb.append(newUser.getActiveCode());
        sb.append("</a>");

        SendEmail sendEmail = new SendEmail();
        sendEmail.send(sb.toString(),"注册验证",email);
        //setLoginedUserInfo(newUser);
        return true;
    }

    @Override
    public boolean checkEmailAvailable(String email) {
        // 检查email是否已被注册，未注册（可用）返回true
        if(this.userDao.getUserByEmail(email) != null) {
            // 已被注册
            return false;
        }
        return true;
    }
    
    @Override
    public boolean logout() {
        Boolean logined = isLogined();
        if (logined) {
            //clearLoginedUserInfo();
            getHttpSession().clear();
        }
        return true;
    }

    @Override
    public UserProfile showUserProfile() {
        int userID = this.getLoginedUserInfo().getUserID();
        return this.userDao.getUserProfile(userID);
    }

    @Override
    public boolean updatePassword(String oldPlainPassword, String newPlainPassword) {
        //int userID = this.getLoginedUserInfo().getUserID();
        //User user = this.userDao.getUserById(userID);
        User user = this.getLoginedUserInfo();    // updateUserProfile已修复，现能确保session中的userInfo的信息与数据库保持一致
        //System.out.println(oldPlainPassword);
        //System.out.println(user.getPassword());
        if(PasswordUtil.checkPassword(oldPlainPassword, user.getPassword())) {
            user.setPassword(PasswordUtil.getEncryptedPassword(newPlainPassword));
            this.userDao.update(user);
            return true;
        }
        else {
            return false;
        }
    }
    
    @Override
    public boolean updateUserProfile(UserProfile newUserProfile) {
        int userID = this.getLoginedUserInfo().getUserID();
        UserProfile userProfile = this.userDao.getUserProfile(userID);
        userProfile.setNickName(newUserProfile.getNickName());
        userProfile.setGender(newUserProfile.getGender());
        userProfile.setMobile(newUserProfile.getMobile());
        userProfile.setProvince(newUserProfile.getProvince());
        userProfile.setCity(newUserProfile.getCity()!=null?newUserProfile.getCity():"请选择");
        userProfile.setDistrict(newUserProfile.getDistrict()!=null?newUserProfile.getDistrict():"请选择");
        userProfile.setAddress(newUserProfile.getAddress());
        boolean result = this.userDao.updateUserProfile(userProfile);
        if(result) {
            setLoginedUserInfo(this.userDao.getUserById(userID));
            return true;
        }
        else {
            return false;
        }
    }
    
    @Override
    public boolean updateUserPicture(File userPicture) {
        User user = this.getLoginedUserInfo();
        if(user.getImageID() != null && !user.getImageID().equals("")) {
            this.imageDao.deleteImageById(user.getImageID());
        }
        String newImageID = this.imageDao.saveImage(userPicture);
        user.setImageID(newImageID);
        this.userDao.update(user);
        return true;
    }
    
    @Override
    public Map addDeliveryAddress(FullAddress fullAddress) {
        int userID = this.getLoginedUserInfo().getUserID();
        Map params = new HashMap();
        FullAddress result = this.userDao.addDeliveryAddress(userID, fullAddress);
        params.put("result", true);
        params.put("newAddressID", result.getFullAddressID());
        params.put("newAddress", result.toFullAddressString());
        return params;
    }
    
    @Override
    public Map getAllDeliveryAddress() {
        int userID = this.getLoginedUserInfo().getUserID();
        Map params = new HashMap();
        List<FullAddress> defaultAddress = new ArrayList<FullAddress>();
        List<FullAddress> otherAddress = new ArrayList<FullAddress>();
        List<FullAddress> all = this.userDao.getAllDeliveryAddress(userID);
        for(FullAddress tmp : all) {
            tmp.setFullAddressString(tmp.toFullAddressString());
            if(tmp.getIsDefault()) {
                defaultAddress.add(tmp);
            }
            else {
                otherAddress.add(tmp);
            }
        }
        params.put("result", true);
        params.put("defaultAddrList", defaultAddress);
        params.put("addrList", otherAddress);
        return params;
    }
    
    @Override
    public Map setDefaultDeliveryAddress(String fullAddressID) {
        int userID = this.getLoginedUserInfo().getUserID();
        Map params = new HashMap();
        FullAddress oldDefault = this.userDao.getDefaultDeliveryAddress(userID);
        this.userDao.setDefaultDeliveryAddress(userID, fullAddressID);
        FullAddress newDefault = this.userDao.getDeliveryAddressByID(userID, fullAddressID);
        params.put("result",true);
        if(oldDefault != null) { 
            params.put("oldDefaultAddrID", oldDefault.getFullAddressID());
            params.put("oldDefaultAddr", oldDefault.toFullAddressString());
        }
        else {
            params.put("oldDefaultAddrID", null);
            params.put("oldDefaultAddr", null);
        }
        params.put("newDefaultAddrID", newDefault.getFullAddressID());
        params.put("newDefaultAddr", newDefault.toFullAddressString());
        return params;
    }
    
    @Override
    public boolean deleteDeliveryAddress(String fullAddressID) {
        int userID = this.getLoginedUserInfo().getUserID();
        this.userDao.removeDeliveryAddress(userID, fullAddressID);
        return true;
    }

    @Override
    public boolean activateUser(String email,String activeCode){
        User user = this.userDao.getUserByEmail(email);
        if(user == null){
            return false;
        }
        if(user.getStatus() != UserStatus.UNACTIVATED){
            return false;
        }
        Date currentTime = new Date();
        if(currentTime.after(user.getDue())){
            return false;
        }
        if(activeCode.equals(user.getActiveCode())){
            user.setStatus(UserStatus.ACTIVATED);
            user.setCredit(100);    // 用户首次激活，赠送100积分
            this.userDao.update(user);
            setLoginedUserInfo(user);
            return true;
        }
        return false;
    }

}