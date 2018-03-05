package hr.fer.opp.users.dao;


import hr.fer.opp.users.model.User;
import hr.fer.opp.users.model.UserWebsite;

import java.util.List;

public interface UserDao {

    List<User> getUsers();

    User findByUserName(String username);

    User findByEmail(String email);

    void addUser(User user);

    UserWebsite getPreviewWebsite(String username);

    void updatePreviewWebsite(User user, UserWebsite previewWebsite);

    UserWebsite getPublicWebsite(String username);

    void updatePublicWebsite(User user, UserWebsite newPublicSite);

    void removeUserByUsername(String userName);

    void editUser(User userForm, String oldUsername);

    void resetRequest(String username, boolean status);
}
