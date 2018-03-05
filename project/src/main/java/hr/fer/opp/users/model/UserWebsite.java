package hr.fer.opp.users.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

import static javax.persistence.GenerationType.IDENTITY;

@Entity
@Table(uniqueConstraints = @UniqueConstraint(columnNames = {"websiteType", "username"}))
public class UserWebsite {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "websiteId", unique = true, nullable = false)
    private Integer websiteId;

    @Column(name = "websiteType", nullable = false)
    private String websiteType;

    @Column(name = "templateId", nullable = false)
    private Integer templateId;

    @Column(name = "imageCount", nullable = false)
    private Integer templateImageCount;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "website", orphanRemoval = true, cascade = CascadeType.ALL)
    private Set<UserWebsitePost> posts = new HashSet<>();

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "username", nullable = false)
    private User author;

    public Integer getTemplateImageCount() {
        return templateImageCount;
    }

    public void setTemplateImageCount(Integer templateImageCount) {
        this.templateImageCount = templateImageCount;
    }

    public Integer getTemplateId() {
        return templateId;
    }

    public void setTemplateId(Integer templateId) {
        this.templateId = templateId;
    }

    public Integer getWebsiteId() {
        return websiteId;
    }

    public void setWebsiteId(Integer websiteId) {
        this.websiteId = websiteId;
    }

    public String getWebsiteType() {
        return websiteType;
    }

    public void setWebsiteType(String websiteType) {
        this.websiteType = websiteType;
    }

    public Set<UserWebsitePost> getPosts() {
        return posts;
    }

    public void setPosts(Set<UserWebsitePost> posts) {
        this.posts = posts;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }
}
