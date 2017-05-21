package hr.fer.opp.users.dao;

import hr.fer.opp.users.UserWebsiteBuilder;
import hr.fer.opp.users.model.User;
import hr.fer.opp.users.model.UserRole;
import hr.fer.opp.users.model.UserWebsite;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class UserDaoImpl implements UserDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Autowired
    private BCryptPasswordEncoder encoder;

    @Override
    public List<User> getUsers() {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "from User as u where (select count(username) from UserRole WHERE username = u.username and " +
                        "role = 'ROLE_USER') = 1"
        );
        List<User> users = query.list();
        session.flush();
        return users;
    }

    public User findByUserName(String username) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from User where username=?");
        query.setParameter(0, username);

        List<User> users = query.list();
        User match = (users.size() > 0) ? users.get(0) : null;
        if (match != null) {
            Hibernate.initialize(match.getUserRole());
            Hibernate.initialize(match.getWebsites());
        }
        session.flush();

        return match;
    }

    @Override
    public User findByEmail(String email) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from User where email=?");
        query.setParameter(0, email);

        List<User> users = query.list();
        User match = (users.size() > 0) ? users.get(0) : null;
        session.flush();

        return match;
    }

    @Override
    public void addUser(User user) {
        Session session = sessionFactory.getCurrentSession();

        UserWebsite previewSite = UserWebsiteBuilder.createDefaultWebsite("preview");
        UserWebsite publicSite = UserWebsiteBuilder.createDefaultWebsite("public");

        previewSite.setAuthor(user);
        publicSite.setAuthor(user);

        user.getWebsites().add(previewSite);
        user.getWebsites().add(publicSite);

        session.persist(user);

        user.setEnabled(true);
        user.setPassword(encoder.encode(user.getPassword()));
        user.setPasswordConfirm(user.getPassword());

        UserRole userRole = new UserRole(user, "ROLE_USER");
        user.addUserRole(userRole);

        session.flush();
    }

    @Override
    public UserWebsite getPreviewWebsite(String username) {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("from UserWebsite where username=? and websiteType=?");
        query.setParameter(0, username);
        query.setParameter(1, "preview");

        List<UserWebsite> sites = query.list();
        UserWebsite match = (sites.size() > 0) ? sites.get(0) : null;

        Hibernate.initialize(match.getPosts());
        session.flush();

        return match;
    }

    @Override
    public void updatePreviewWebsite(User user, UserWebsite previewWebsite) {
        Session session = sessionFactory.getCurrentSession();

        /* delete old preview site */
        Query query = session.createQuery("from UserWebsite where username=? and websiteType=?");
        query.setParameter(0, user.getUsername());
        query.setParameter(1, "preview");
        List<UserWebsite> roles = query.list();
        UserWebsite role = (roles.size() > 0) ? roles.get(0) : null;
        session.delete(role);
        session.flush();

        /* insert new preview site */
        previewWebsite.setAuthor(user);
        session.persist(previewWebsite);

        session.flush();
    }

    @Override
    public UserWebsite getPublicWebsite(String username) {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("from UserWebsite where username=? and websiteType=?");
        query.setParameter(0, username);
        query.setParameter(1, "public");

        List<UserWebsite> sites = query.list();
        UserWebsite match = (sites.size() > 0) ? sites.get(0) : null;

        Hibernate.initialize(match.getPosts());
        session.flush();

        return match;
    }

    @Override
    public void updatePublicWebsite(User user, UserWebsite newPublicSite) {
        Session session = sessionFactory.getCurrentSession();

        /* delete old public site */
        Query query = session.createQuery("from UserWebsite where username=? and websiteType=?");
        query.setParameter(0, user.getUsername());
        query.setParameter(1, "public");
        List<UserWebsite> roles = query.list();
        UserWebsite role = (roles.size() > 0) ? roles.get(0) : null;
        session.delete(role);
        session.flush();

        /* insert new public site */
        newPublicSite.setAuthor(user);
        session.persist(newPublicSite);

        session.flush();
    }

    @Override
    public void removeUserByUsername(String userName) {
        Session session = sessionFactory.getCurrentSession();
        session.delete(findByUserName(userName));
        session.flush();
    }

    @Override
    public void editUser(User userForm, String oldUsername) {
        Session session = sessionFactory.getCurrentSession();

        String password = encoder.encode(userForm.getPassword());
        String firstName = userForm.getFirstName();
        String lastName = userForm.getLastName();
        String email = userForm.getEmail();

        User user = findByUserName(oldUsername);
        user.setPassword(password);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setEnabled(true);

        session.saveOrUpdate(user);
        session.flush();
    }

    @Override
    public void resetRequest(String username, boolean status) {
        Session session = sessionFactory.getCurrentSession();
        User user = findByUserName(username);
        user.setResetRequested(status);
        session.saveOrUpdate(user);
        session.flush();
    }

}
