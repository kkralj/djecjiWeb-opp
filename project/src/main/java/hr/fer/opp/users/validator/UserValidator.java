package hr.fer.opp.users.validator;


import hr.fer.opp.users.dao.UserDao;
import hr.fer.opp.users.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UserValidator implements Validator {

    @Autowired
    private UserDao userDao;

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "NotEmpty");

        ValidationUtils.rejectIfEmpty(errors, "password", "NotEmpty");
        ValidationUtils.rejectIfEmpty(errors, "passwordConfirm", "NotEmpty");

        if (errors.hasErrors()) {
            return;
        }

        if (user.getFirstName().length() < 2 || user.getFirstName().length() > 50) {
            errors.rejectValue("firstName", "Size.userForm.name");

        } else if (user.getLastName().length() < 2 || user.getLastName().length() > 50) {
            errors.rejectValue("lastName", "Size.userForm.name");

        } else if (user.getEmail().length() < 2 || user.getLastName().length() > 62) {
            errors.rejectValue("email", "Size.userForm.email");

        } else if (user.getUsername().length() < 2 || user.getUsername().length() > 45) {
            errors.rejectValue("username", "Size.userForm.username");

        } else if (user.getPassword().length() < 4 || user.getPassword().length() > 32) {
            errors.rejectValue("password", "Size.userForm.password");

        } else if (!user.getPasswordConfirm().equals(user.getPassword())) {
            errors.rejectValue("passwordConfirm", "Diff.userForm.passwordConfirm");

        } else if (!isValidEmailAddress(user.getEmail())) {
            errors.rejectValue("email", "Invalid.userForm.email.format");

        } else if (!user.isUpdatingInformation() && userDao.findByUserName(user.getUsername()) != null) {
            errors.rejectValue("username", "Duplicate.userForm.username");

        } else if ((user.isUpdatingInformation() && userDao.findByEmail(user.getEmail()) != null &&
                !userDao.findByEmail(user.getEmail()).getUsername().equals(user
                        .getUsername())) // someone else has that email
                || (!user.isUpdatingInformation() && userDao.findByEmail(user.getEmail()) != null)) {
            errors.rejectValue("email", "Duplicate.userForm.email");

        }
    }

    private boolean isValidEmailAddress(String emailAddress) {
        String expression = "^[\\w\\-]([.\\w])+[\\w]+@([\\w\\-]+\\.)+[A-Z]{2,4}$";
        Pattern pattern = Pattern.compile(expression, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(emailAddress);
        return matcher.matches();
    }
}
