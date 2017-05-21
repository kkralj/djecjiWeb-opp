package hr.fer.opp.users.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity()
@Table()
public class User {

    @Id
    @Column(name = "username", unique = true, nullable = false, length = 45)
    private String username;

    @Column(name = "password", nullable = false, length = 60)
    private String password;

    @Column(name = "enabled", nullable = false)
    private boolean enabled;

    @Column(name = "resetRequested", nullable = false)
    private boolean resetRequested;

    @Column(name = "firstName", nullable = false, length = 50)
    private String firstName;

    @Column(name = "lastName", nullable = false, length = 50)
    private String lastName;

    @Column(name = "email", unique = true, nullable = false, length = 62)
    private String email;

    @Transient
    private String passwordConfirm;

    @Transient
    private boolean updatingInformation;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "author", orphanRemoval = true, cascade = CascadeType.ALL)
    private Set<UserWebsite> websites = new HashSet<>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", orphanRemoval = true, cascade = CascadeType.ALL)
    private Set<UserRole> userRole = new HashSet<>();

    public boolean isRegularUser() {
        for (UserRole userRole : getUserRole()) {
            if (userRole.getRole().equals("ROLE_USER")) {
                return true;
            }
        }
        return false;
    }

    public User() {
    }

    public boolean isUpdatingInformation() {
        return updatingInformation;
    }

    public void setUpdatingInformation(boolean updatingInformation) {
        this.updatingInformation = updatingInformation;
    }

    public boolean isResetRequested() {
        return resetRequested;
    }

    public void setResetRequested(boolean resetRequested) {
        this.resetRequested = resetRequested;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isEnabled() {
        return this.enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public Set<UserRole> getUserRole() {
        return this.userRole;
    }

    public void setUserRole(Set<UserRole> userRole) {
        this.userRole = userRole;
    }

    public void addUserRole(UserRole role) {
        this.userRole.add(role);
    }

    public String getFirstName() {
        return firstName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Set<UserWebsite> getWebsites() {
        return websites;
    }

    public void setWebsites(Set<UserWebsite> websites) {
        this.websites = websites;
    }

}