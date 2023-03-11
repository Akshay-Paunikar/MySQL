CREATE DATABASE scientists;
USE scientists;

CREATE TABLE scientists (
  ssn int,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (ssn)
);

INSERT INTO Scientists(ssn, name) VALUES
(123234877,'Michael Rogers'),
(152934485,'Anand Manikutty'),
(222364883, 'Carol Smith'),
(326587417,'Joe Stevens'),
(332154719,'Mary-Anne Foster'),	
(332569843,'George ODonnell'),
(546523478,'John Doe'),
(631231482,'David Smith'),
(654873219,'Zacary Efron'),
(745685214,'Eric Goldsmith'),
(845657245,'Elizabeth Doe'),
(845657246,'Kumar Swamy');

CREATE TABLE projects (
  code VARCHAR(255),
  name VARCHAR(255) NOT NULL,
  hours INT,
  PRIMARY KEY(code)
);

INSERT INTO Projects (code, name, hours) VALUES 
('AeH1','Winds: Studying Bernoullis Principle', 156),
('AeH2','Aerodynamics and Bridge Design',189),
('AeH3','Aerodynamics and Gas Mileage', 256),
('AeH4','Aerodynamics and Ice Hockey', 789),
('AeH5','Aerodynamics of a Football', 98),
('AeH6','Aerodynamics of Air Hockey',89),
('Ast1','A Matter of Time',112),
('Ast2','A Puzzling Parallax', 299),
('Ast3','Build Your Own Telescope', 6546),
('Bte1','Juicy: Extracting Apple Juice with Pectinase', 321),
('Bte2','A Magnetic Primer Designer', 9684),
('Bte3','Bacterial Transformation Efficiency', 321),
('Che1','A Silver-Cleaning Battery', 545),
('Che2','A Soluble Separation Solution', 778);

	
CREATE TABLE assignedto (
  scientist INT NOT NULL,
  project VARCHAR(255) NOT NULL,
  Primary Key (scientist, project),
  Foreign Key (scientist) references scientists (ssn),
  Foreign Key (project) references projects (code)
);

INSERT INTO AssignedTo (scientist, project) VALUES 
(123234877,'AeH1'),
(152934485,'AeH3'),
(222364883,'Ast3'),
(326587417,'Ast3'),
(332154719,'Bte1'),
(546523478,'Che1'),
(631231482,'Ast3'),
(654873219,'Che1'),
(745685214,'AeH3'),
(845657245,'Ast1'),
(845657246,'Ast2'),
(332569843,'AeH4');

-- 1.List all the scientists' names, their projects' names, and the hours worked by that scientist on each project, in 
-- alphabetical order of project name, then scientist name.
SELECT S.name, P.name, P.hours FROM scientists AS S, projects AS P, assignedto AS AT
WHERE S.ssn = AT.scientist
AND AT.project = P.code
ORDER BY P.name, S.name;



















