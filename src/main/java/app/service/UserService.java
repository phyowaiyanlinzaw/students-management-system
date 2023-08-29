package app.service;

import app.model.User;

import java.util.List;

public interface UserService {

    int registerUser(User user);

    int updateUser(User user);

    int deleteUser(int userId);

    User getOneUser(int userId);

    List<User> getAllUsers();

    List<User> getAllUsersAndAdmin();

}
