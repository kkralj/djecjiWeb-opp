package hr.fer.opp.users.model;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

@Entity
@Table()
public class UserWebsitePost {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "postId", unique = true, nullable = false)
    private Integer postId;

    @Lob
    @Column(name = "postValue", nullable = false)
    private String postValue;

    @Column(name = "postKey", nullable = false)
    private String postKey;

    @Column(name = "postFont", nullable = false)
    private String postFont = "Arial";

    @Column(name = "postBackground", nullable = false)
    private String postBackgroundColor = "FFFFFF";

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "websiteId", nullable = false)
    private UserWebsite website;

    public UserWebsitePost() {
    }

    public UserWebsitePost(String postKey, String postValue) {
        this.postValue = postValue;
        this.postKey = postKey;
    }

    public String getPostFont() {
        return postFont;
    }

    public void setPostFont(String postFont) {
        this.postFont = postFont;
    }

    public String getPostBackgroundColor() {
        return postBackgroundColor;
    }

    public void setPostBackgroundColor(String postBackgroundColor) {
        this.postBackgroundColor = postBackgroundColor;
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public String getPostValue() {
        return postValue;
    }

    public void setPostValue(String postValue) {
        this.postValue = postValue;
    }

    public String getPostKey() {
        return postKey;
    }

    public void setPostKey(String postKey) {
        this.postKey = postKey;
    }

    public UserWebsite getWebsite() {
        return website;
    }

    public void setWebsite(UserWebsite website) {
        this.website = website;
    }
}
