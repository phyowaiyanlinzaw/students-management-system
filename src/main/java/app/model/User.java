package app.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;

@Data
@Entity
@Table(name = "user")
@NoArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "USERID")
    private int userId;

    @Column(name = "DISPLAYUSERID")
    private String displayUserId;

    @Column(name = "USERNAME")
    private String userName;

    @Column(name = "USEREMAIL")
    private String userEmail;

    @Transient
    private String userIdentifier;

    @Column(name = "USERPASSWORD")
    private String userPassword;

    @Transient
    private String userConfirmPassword;

    @Column(name = "STATUS")
    private String status;

    @Column(name = "USERROLE")
    private String userRole;

}
