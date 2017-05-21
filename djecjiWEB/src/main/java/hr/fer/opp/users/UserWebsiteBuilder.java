package hr.fer.opp.users;

import hr.fer.opp.users.model.UserWebsite;
import hr.fer.opp.users.model.UserWebsitePost;
import org.springframework.security.crypto.codec.Base64;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;

public class UserWebsiteBuilder {

    /**
     * Method used to generate default template model which will be used as when user changes his page template.
     *
     * @param templateNum number of new template selected by user
     * @return default template model
     */
    public static ModelAndView createDefaultModel(Integer templateNum, String username) {
        ModelAndView model = new ModelAndView();
        model.setViewName("edit/edit-" + templateNum);
        model.addObject("siteId", -1);
        model.addObject("username", username);

        List<String> textData = new ArrayList<>();
        List<String> textFonts = new ArrayList<>();
        List<String> textColors = new ArrayList<>();

        textData.add("<h1>Your page title goes here</h1>");
        textData.add("<h2>This is your content title</h2><p>This is your content</p>");

        for (int i = 0; i < 2; i++) {
            textFonts.add("Arial");
            textColors.add("#FFFFFF");
        }

        if (templateNum == 3) { // add one more post because template 3 has three forms.
            textData.add("<h2>This is your another content title</h2><p>This is another your content</p>");
            textFonts.add("Arial");
            textColors.add("#FFFFFF");
        }

        for (int i = 0; i < textData.size(); i++) {
            /* add text */
            model.addObject("textarea" + i, textData.get(i));

            /* add color and font */
            model.addObject("txt" + i + "font", textFonts.get(i));
            model.addObject("txt" + i + "background", textColors.get(i));
        }

        return model;
    }

    /**
     * Method used to create edit model template based on the last saved website preview.
     *
     * @param previewWebsite last saved preview
     * @param username       users username
     * @param imgDirectory   image directory
     * @return edit model of the last saved preview
     */
    public static ModelAndView createEditModel(UserWebsite previewWebsite, String username, String imgDirectory) {
        ModelAndView model = new ModelAndView();

        model.addObject("username", username);
        model.addObject("siteId", previewWebsite.getWebsiteId());

        /* store posts */
        storePosts(model, previewWebsite);

        /* store images */
        for (int i = 0; i < previewWebsite.getTemplateImageCount(); i++) {
            String picturePath = imgDirectory + previewWebsite.getWebsiteId() + "-" + i + ".png";
            if (Files.exists(Paths.get(picturePath))) {
                model.addObject("img" + i + "exists", true);
            }
        }

        model.setViewName("edit/edit-" + previewWebsite.getTemplateId());

        return model;
    }

    private static void storePosts(ModelAndView model, UserWebsite website) {
        for (UserWebsitePost post : website.getPosts()) {
            /* text */
            model.addObject(post.getPostKey(), post.getPostValue());

            /* color and font */
            String index = post.getPostKey().substring(post.getPostKey().length() - 1);
            model.addObject("txt" + index + "font", post.getPostFont());
            model.addObject("txt" + index + "background", post.getPostBackgroundColor());
        }

    }

    public static ModelAndView createPreviewModel(Integer templateId, Integer siteId, String[] textData,
                                                  String[] textFonts, String[] textColors,
                                                  MultipartFile[] images, String imgDirectory,
                                                  boolean useOldImages) {
        ModelAndView model = new ModelAndView();
        model.setViewName("/preview/page-" + templateId);

        if (textFonts.length != textColors.length || textFonts.length != textData.length) {
            throw new IllegalArgumentException();
        }

        for (int i = 0; i < textData.length; i++) {
            /* add post */
            model.addObject("textarea" + i, textData[i]);

            /* add font and color */
            model.addObject("txt" + i + "font", textFonts[i]);
            model.addObject("txt" + i + "background", textColors[i]);
        }

        /* add images */
        for (int i = 0; i < images.length; i++) {

            if (!images[i].isEmpty()) { // user submitted new image
                try {
                    model.addObject("img" + i + "data", new String(Base64.encode(images[i].getBytes())));
                    model.addObject("img" + i + "exists", true);
                } catch (IOException e) {
                    e.printStackTrace();
                }

            } else if (useOldImages) { // check if old image exists
                String picturePath = imgDirectory + siteId + "-" + i + ".png";
                Path path = Paths.get(picturePath);
                if (Files.exists(path)) {
                    try {
                        model.addObject("img" + i + "data", new String(Base64.encode(Files.readAllBytes(path))));
                        model.addObject("img" + i + "exists", true);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        return model;
    }

    public static UserWebsite createUserWebsite(Integer templateId, String[] textData, String[] textFonts,
                                                String[] textColors, String websiteType) {
        UserWebsite website = new UserWebsite();
        website.setTemplateId(templateId);
        website.setWebsiteType(websiteType);

        /* template 1 and 2 -> max 2 images, template 3 -> 1 image */
        int imageCount = (templateId <= 2) ? 2 : 1;
        website.setTemplateImageCount(imageCount);

        /* template 1 and 2 -> 2 posts, template 3 -> 3 posts */
        int postCount = (templateId <= 2) ? 2 : 3;

        for (int i = 0; i < postCount; i++) { // first template has two post areas
            UserWebsitePost post = new UserWebsitePost("textarea" + i, textData[i]);
            post.setPostFont(textFonts[i]);
            post.setPostBackgroundColor(textColors[i]);
            post.setWebsite(website);
            website.getPosts().add(post);
        }

        return website;
    }

    /**
     * Method used to create website that is initially default for every user. This website will be assigned to the user
     * after the registration process, and it is used for both public and preview models.
     *
     * @param websiteType public or preview
     * @return default user website
     */
    public static UserWebsite createDefaultWebsite(String websiteType) {
        return createUserWebsite(1,
                new String[]{
                        "<h1>Your page title goes here</h1>",
                        "<h2>This is your content title</h2><p>This is your content</p>"
                },
                new String[]{
                        "Arial", "Arial"
                },
                new String[]{
                        "#FFFFFF", "#FFFFFF"
                },
                websiteType
        );
    }

    public static ModelAndView createPublicModel(UserWebsite publicSite, String imgDirectory) {
        ModelAndView model = new ModelAndView();
        model.setViewName("/" + publicSite.getWebsiteType() + "/page-" + publicSite.getTemplateId());

        model.addObject("siteId", publicSite.getWebsiteId()); // TODO: Why this?

        storePosts(model, publicSite);

        /* add images */
        for (int i = 0; i < publicSite.getTemplateImageCount(); i++) {
            String picturePath = imgDirectory + publicSite.getWebsiteId() + "-" + i + ".png";
            if (Files.exists(Paths.get(picturePath))) {
                model.addObject("img" + i + "exists", true);
            }
        }

        return model;
    }

    public static void removeImages(UserWebsite publicSite, String imgDirectory) {
        for (int i = 0; i < publicSite.getTemplateImageCount(); i++) {
            Path picturePath = Paths.get(imgDirectory + publicSite.getWebsiteId() + "-" + i + ".png");
            if (Files.exists(picturePath)) {
                try {
                    Files.delete(picturePath);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void copyImages(UserWebsite source, UserWebsite destination, String sourceImgDir, String destImgDir) {
        for (int i = 0; i < source.getTemplateImageCount(); i++) {
            String oldPicturePath = sourceImgDir + source.getWebsiteId() + "-" + i + ".png";
            Path oldPath = Paths.get(oldPicturePath);

            replacePicture(oldPath, destImgDir, destination.getWebsiteId().toString(), String.valueOf(i));
        }
    }

    public static void updateImages(UserWebsite oldPreviewSite, UserWebsite newPreviewSite,
                                    MultipartFile[] images, String oldImgDirectory, String newImgDirectory,
                                    boolean useOldImages) {

        for (int i = 0; i < images.length; i++) {
            if (images[i] != null && !images[i].isEmpty()) {
                Path picturePath = Paths.get(newImgDirectory + newPreviewSite.getWebsiteId() + "-" + i + ".png");
                try {
                    Files.write(picturePath, images[i].getBytes());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (useOldImages) {
                String oldPicturePath = oldImgDirectory + oldPreviewSite.getWebsiteId() + "-" + i + ".png";
                Path oldPath = Paths.get(oldPicturePath);

                replacePicture(oldPath, newImgDirectory, newPreviewSite.getWebsiteId().toString(), String.valueOf(i));
            }
        }

    }

    private static void replacePicture(Path oldPath, String newImgDirectory, String websiteId, String id) {
        if (Files.exists(oldPath)) { // rename old picture
            String newPicturePath = newImgDirectory + websiteId + "-" + id + ".png";
            File newPictureFile = new File(newPicturePath);
            try {
                Files.copy(oldPath, newPictureFile.toPath(), REPLACE_EXISTING);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}
