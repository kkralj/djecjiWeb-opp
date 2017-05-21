INSERT INTO USER(username,password,enabled, email, firstName, lastName)
VALUES ('admin','$2a$10$hZTwXfNKaB1Q2rRE4yw7SOPyZedhm9QY/CqXZYe1Q6qgizFx9Vee2', true, 'admin@localhost.com', 'Ivo', 'Ivic'); -- admin
INSERT INTO USERROLE (username, role)
VALUES ('admin', 'ROLE_USER');
INSERT INTO USERROLE (username, role)
VALUES ('admin', 'ROLE_ADMIN');



INSERT INTO USER(username,password,enabled, email, firstName, lastName)
VALUES ('user','$2a$10$DuAbi/Z0KUDS6lqH8Nylv.JZ9GCPWglBYJfZw3nOXOzinVxe6a4ji', true, 'regular@user.com', 'Pero', 'Peric'); -- user
INSERT INTO USERROLE (username, role)
VALUES ('user', 'ROLE_USER');