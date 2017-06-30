package service;

import java.util.Map;

public interface UserService {
    public boolean isLogined();
    public Map login(String email, String plainPassword);
    public boolean register(String email, String plainPassword);
    public boolean logout();
    public Map showUserProfile(int userID);
    public boolean updateUserProfile(int userID, Map newUserProfile);
    public boolean updateUserPassword(String oldPassword, String newPassword);
}