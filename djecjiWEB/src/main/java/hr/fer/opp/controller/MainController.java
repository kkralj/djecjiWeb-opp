package hr.fer.opp.controller;

import hr.fer.opp.users.UserWebsiteBuilder;
import hr.fer.opp.users.dao.UserDao;
import hr.fer.opp.users.model.User;
import hr.fer.opp.users.model.UserWebsite;
import hr.fer.opp.users.model.UserWebsitePost;
import hr.fer.opp.users.validator.UserValidator;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.IOException;
import java.util.Collection;
import java.util.List;

@Controller()
public class MainController {

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping(value = "/edit/{templateNum}", method = RequestMethod.GET)
    public ModelAndView templateChange(@PathVariable Integer templateNum, HttpServletRequest request) {

        UserWebsite oldPreview = userDao.getPreviewWebsite(getActiveUsername());
        if (Integer.compare(oldPreview.getTemplateId(), templateNum) == 0) {
            return edit(request);
        }

        return UserWebsiteBuilder.createDefaultModel(templateNum, getActiveUsername());
    }

    @RequestMapping(value = "/edit/resetRequest")
    public ModelAndView resetRequest() {
        userDao.resetRequest(getActiveUsername(), true);
        return new ModelAndView("redirect:/edit");
    }

    @RequestMapping(value = "/edit/setPublicAsPreview", method = RequestMethod.GET)
    public ModelAndView setPublicAsPreview(HttpServletRequest request) {

        String username = getActiveUsername();
        User user = userDao.findByUserName(username);
        UserWebsite previewSite = userDao.getPreviewWebsite(username);
        UserWebsite publicSite = userDao.getPublicWebsite(username);

        UserWebsite newPreviewSite = new UserWebsite();
        newPreviewSite.setAuthor(user);
        newPreviewSite.setWebsiteType("preview");
        newPreviewSite.setTemplateId(publicSite.getTemplateId());
        newPreviewSite.setTemplateImageCount(publicSite.getTemplateImageCount());

        for (UserWebsitePost post : publicSite.getPosts()) {
            UserWebsitePost newPreviewPost = new UserWebsitePost();
            newPreviewPost.setPostValue(post.getPostValue());
            newPreviewPost.setPostKey(post.getPostKey());
            newPreviewPost.setPostFont(post.getPostFont());
            newPreviewPost.setPostBackgroundColor(post.getPostBackgroundColor());
            newPreviewPost.setWebsite(newPreviewSite);

            newPreviewSite.getPosts().add(newPreviewPost);
        }

        String rootDirectory = request.getSession().getServletContext().getRealPath("/");
        String previmgDirectory = rootDirectory + "/WEB-INF/resources/images/preview/";
        String pubimgDirectory = rootDirectory + "/WEB-INF/resources/images/public/";

        UserWebsiteBuilder.removeImages(previewSite, previmgDirectory);

        userDao.updatePreviewWebsite(user, newPreviewSite);

        UserWebsiteBuilder.copyImages(publicSite, newPreviewSite, pubimgDirectory, previmgDirectory);

        return new ModelAndView("redirect:/edit");
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView edit(HttpServletRequest request) {

        String username = getActiveUsername();
        UserWebsite previewWebsite = userDao.getPreviewWebsite(username);

        String rootDirectory = request.getSession().getServletContext().getRealPath("/");
        String imgDirectory = rootDirectory + "/WEB-INF/resources/images/preview/";

        return UserWebsiteBuilder.createEditModel(previewWebsite, username, imgDirectory);
    }

    @RequestMapping(value = "/preview", method = RequestMethod.POST)
    public ModelAndView preview(@RequestParam("templateId") Integer templateId,
                                @RequestParam("siteId") Integer siteId,
                                @RequestParam("tarea") String[] textData,
                                @RequestParam("farea") String[] textFonts,
                                @RequestParam("carea") String[] textColors,
                                @RequestParam(value = "image", required = false) MultipartFile[] images,
                                HttpServletRequest request) {

        String rootDirectory = request.getSession().getServletContext().getRealPath("/");
        String imgDirectory = rootDirectory + "/WEB-INF/resources/images/preview/";

        UserWebsite savedPreview = userDao.getPreviewWebsite(getActiveUsername());
        boolean useOldImages = (Integer.compare(templateId, savedPreview.getTemplateId()) == 0);

        return UserWebsiteBuilder.createPreviewModel(templateId, siteId, textData,
                textFonts, textColors, images, imgDirectory, useOldImages);
    }

    @RequestMapping(value = "/preview/save", method = RequestMethod.POST)
    public ModelAndView savePreview(@RequestParam("templateId") Integer templateId,
                                    @RequestParam("tarea") String[] textData,
                                    @RequestParam("farea") String[] textFonts,
                                    @RequestParam("carea") String[] textColors,
                                    @RequestParam(value = "image", required = false) MultipartFile[] images,
                                    HttpServletRequest request) {

        String username = getActiveUsername();
        User user = userDao.findByUserName(username);

        UserWebsite newPreviewSite = UserWebsiteBuilder.createUserWebsite(templateId, textData, textFonts,
                textColors, "preview");
        UserWebsite oldPreviewSite = userDao.getPreviewWebsite(username);

        userDao.updatePreviewWebsite(user, newPreviewSite); // remove old and store new site

        String rootDirectory = request.getSession().getServletContext().getRealPath("/");
        String imgDirectory = rootDirectory + "/WEB-INF/resources/images/preview/";

        boolean useOldImages = (Integer.compare(templateId, oldPreviewSite.getTemplateId()) == 0);

        UserWebsiteBuilder.updateImages(oldPreviewSite, newPreviewSite, images, imgDirectory, imgDirectory,
                useOldImages);
        UserWebsiteBuilder.removeImages(oldPreviewSite, imgDirectory);

        return new ModelAndView("redirect:/edit");
    }

    @RequestMapping(value = "/preview/publish", method = RequestMethod.POST)
    public ModelAndView publish(@RequestParam("templateId") Integer templateId,
                                @RequestParam("tarea") String[] textData,
                                @RequestParam("farea") String[] textFonts,
                                @RequestParam("carea") String[] textColors,
                                @RequestParam(value = "image", required = false) MultipartFile[] images,
                                HttpServletRequest request) {

        savePreview(templateId, textData, textFonts, textColors, images, request);

        String username = getActiveUsername();
        User user = userDao.findByUserName(username);

        UserWebsite newPublicSite = UserWebsiteBuilder.createUserWebsite(templateId, textData, textFonts,
                textColors, "public");
        UserWebsite oldPublicSite = userDao.getPublicWebsite(username);

        userDao.updatePublicWebsite(user, newPublicSite);

        String rootDirectory = request.getSession().getServletContext().getRealPath("/");
        String oldImgDirectory = rootDirectory + "/WEB-INF/resources/images/preview/";
        String newImgDirectory = rootDirectory + "/WEB-INF/resources/images/public/";

        UserWebsite previewSite = userDao.getPreviewWebsite(username);

        boolean useOldImages = (Integer.compare(templateId, previewSite.getTemplateId()) == 0); // always true

        UserWebsiteBuilder.updateImages(previewSite, newPublicSite, images, oldImgDirectory, newImgDirectory, true);

        UserWebsiteBuilder.removeImages(oldPublicSite, newImgDirectory);

        return new ModelAndView("redirect:/edit");
    }

    @RequestMapping(value = "/view/{userName}", method = RequestMethod.GET)
    public ModelAndView preview(@NotBlank @PathVariable String userName, HttpServletRequest request) {

        User user = userDao.findByUserName(userName);
        if (user == null || !user.isRegularUser()) {
            return new ModelAndView("404"); //redirect?
        }

        UserWebsite publicSite = userDao.getPublicWebsite(user.getUsername());

        String rootDirectory = request.getSession().getServletContext().getRealPath("/");
        String imgDirectory = rootDirectory + "/WEB-INF/resources/images/public/";

        return UserWebsiteBuilder.createPublicModel(publicSite, imgDirectory);
    }


    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView register() {
        ModelAndView model = new ModelAndView();
        User user = new User();
        model.addObject("user", user);
        model.setViewName("register");
        return model;
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ModelAndView register(@Valid @ModelAttribute("user") User userForm, BindingResult bindingResult) {

        userValidator.validate(userForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return new ModelAndView("register");
        }

        userDao.addUser(userForm);

        return new ModelAndView("redirect:/");
    }

    @RequestMapping(value = {"/"}, method = RequestMethod.GET)
    public ModelAndView defaultPage() {
        ModelAndView model = new ModelAndView();

        model.setViewName("home");

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>)
                SecurityContextHolder.getContext().getAuthentication().getAuthorities();

        if (authorities != null) {
            for (SimpleGrantedAuthority authority : authorities) {
                if (authority.getAuthority().equals("ROLE_USER")) {
                    model.addObject("user", ((UserDetails) principal).getUsername());
                    break;
                }
            }
        }

        return model;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login(@RequestParam(value = "error", required = false) String error,
                              @RequestParam(value = "logout", required = false) String logout,
                              HttpServletRequest request) {
        ModelAndView model = new ModelAndView();

        if (error != null) {
            model.addObject("error", getErrorMessage(request, "SPRING_SECURITY_LAST_EXCEPTION"));
        }

        if (logout != null) {
            model.addObject("msg", "Uspješno ste odjavljeni.");
        }

        model.setViewName("login");

        return model;
    }

    // for 403 access denied page
    @RequestMapping(value = "/403", method = RequestMethod.GET)
    public ModelAndView accessDenied() {
        ModelAndView model = new ModelAndView();

        // check if user is logged in
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            model.addObject("username", userDetail.getUsername());
        }

        model.setViewName("403");

        return model;
    }

    @RequestMapping(value = "/about", method = RequestMethod.GET)
    public ModelAndView about() {
        ModelAndView model = new ModelAndView();
        model.setViewName("about");
        return model;
    }

    // customize the error message
    private String getErrorMessage(HttpServletRequest request, String key) {
        Exception exception = (Exception) request.getSession().getAttribute(key);

        String error = "";
        if (exception instanceof BadCredentialsException) {
            error = "Pogrešno korisničko ime i lozinka!";
        } else if (exception instanceof LockedException) {
            error = exception.getMessage();
        } else {
            error = "Pogrešno korisničko ime i lozinka!";
        }

        return error;
    }

    private String getActiveUsername() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return ((UserDetails) principal).getUsername();
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public ModelAndView adminPage() {
        ModelAndView model = new ModelAndView();
        model.setViewName("admin/admin");
        return model;
    }

    @RequestMapping(value = "/admin/userList")
    public ModelAndView userList() {
        ModelAndView model = new ModelAndView();

        List<User> users = userDao.getUsers();
        model.addObject("users", users);

        model.setViewName("admin/userList");
        return model;
    }

    @RequestMapping(value = "/admin/removeUser/{username}")
    public ModelAndView removeUser(@NotBlank @PathVariable String username, HttpServletRequest request) {
        ModelAndView model = new ModelAndView();

        String rootDirectory = request.getSession().getServletContext().getRealPath("/");

        UserWebsite previewSite = userDao.getPreviewWebsite(username);
        String previewDir = rootDirectory + "/WEB-INF/resources/images/preview/";
        UserWebsiteBuilder.removeImages(previewSite, previewDir);

        UserWebsite publicSite = userDao.getPublicWebsite(username);
        String publicDir = rootDirectory + "/WEB-INF/resources/images/public/";
        UserWebsiteBuilder.removeImages(publicSite, publicDir);

        userDao.removeUserByUsername(username);

        model.setViewName("redirect:/admin/userList");
        return model;
    }

    @RequestMapping(value = "/admin/resetPage/{username}")
    public ModelAndView resetPage(@NotBlank @PathVariable String username, HttpServletRequest request) {
        ModelAndView model = new ModelAndView();

        UserWebsite previewSite = UserWebsiteBuilder.createDefaultWebsite("preview");
        UserWebsite publicSite = UserWebsiteBuilder.createDefaultWebsite("public");

        UserWebsite oldPreviewSite = userDao.getPreviewWebsite(username);
        UserWebsite oldPublicSite = userDao.getPublicWebsite(username);

        String rootDirectory = request.getSession().getServletContext().getRealPath("/");

        String previewDir = rootDirectory + "/WEB-INF/resources/images/preview/";
        UserWebsiteBuilder.removeImages(oldPreviewSite, previewDir);

        String publicDir = rootDirectory + "/WEB-INF/resources/images/public/";
        UserWebsiteBuilder.removeImages(oldPublicSite, publicDir);

        User user = userDao.findByUserName(username);

        userDao.updatePreviewWebsite(user, previewSite);
        userDao.updatePublicWebsite(user, publicSite);
        userDao.resetRequest(username, false);

        model.setViewName("redirect:/admin/userList");
        return model;
    }

    @RequestMapping(value = "/admin/addUser", method = RequestMethod.GET)
    public ModelAndView addUser() {
        ModelAndView model = new ModelAndView();

        User user = new User();
        model.addObject("user", user);

        model.setViewName("admin/addUser");
        return model;
    }

    @RequestMapping(value = "/admin/addUser", method = RequestMethod.POST)
    public ModelAndView addUser(@Valid @ModelAttribute("user") User userForm, BindingResult bindingResult) {

        userValidator.validate(userForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return new ModelAndView("admin/addUser");
        }

        userDao.addUser(userForm);

        return new ModelAndView("redirect:/admin/userList");
    }

    @RequestMapping(value = "/admin/editUser/{username}", method = RequestMethod.GET)
    public ModelAndView editUser(@NotBlank @PathVariable String username) {
        ModelAndView model = new ModelAndView();

        User user = userDao.findByUserName(username);
        user.setPassword("");
        user.setPasswordConfirm("");
        model.addObject("user", user);

        model.setViewName("/admin/editUser");
        return model;
    }

    @RequestMapping(value = "/admin/editUser/{username}", method = RequestMethod.POST)
    public ModelAndView editUser(@Valid @ModelAttribute("user") User userForm, BindingResult bindingResult,
                                 @NotBlank @PathVariable String username) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return new ModelAndView("admin/editUser");
        }

        userDao.editUser(userForm, username);

        return new ModelAndView("redirect:/admin/userList");
    }

    @RequestMapping(value = "/admin/userInfo/{username}")
    public ModelAndView userInfo(@NotBlank @PathVariable String username) throws IOException {
        ModelAndView model = new ModelAndView();

        User user = userDao.findByUserName(username);
        model.addObject("user", user);

        model.setViewName("admin/viewUser");
        return model;
    }

    /* --- */

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public ModelAndView test() {

        ModelAndView model = new ModelAndView();

        model.addObject("textarea1", "<h1>Your page title goes here</h1>");
        model.addObject("textarea2", "<h2>This is your content title</h2><p>This is your content</p>");
        model.setViewName("jqte/demo");

        return model;
    }


}