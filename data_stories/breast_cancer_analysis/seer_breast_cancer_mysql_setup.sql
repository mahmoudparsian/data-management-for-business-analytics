-- MySQL Table Creation Script for SEER Breast Cancer Dataset

CREATE TABLE seer_breast_cancer (
    age INT,
    race VARCHAR(255),
    marital_status VARCHAR(255),
    x VARCHAR(10),
    t_stage VARCHAR(10),
    n_stage VARCHAR(10),
    sixth_6_stage VARCHAR(50),
    grade VARCHAR(100),
    a_stage VARCHAR(50),
    tumor_size INT,
    estrogen_status VARCHAR(20),
    progesterone_status VARCHAR(20),
    regional_node_examined INT,
    reginol_node_positive INT,
    survival_months INT,
    status VARCHAR(20)
);

-- Sample Inserts
INSERT INTO seer_breast_cancer (age, race, marital_status, x, t_stage, n_stage, sixth_6_stage, grade, a_stage, tumor_size, estrogen_status, progesterone_status, regional_node_examined, reginol_node_positive, survival_months, status)
VALUES
(43, 'Other (American Indian/AK Native, Asian/Pacific Islander)', 'Married (including common law)', NULL, 'T2', 'N3', 'IIIC', 'Moderately differentiated; Grade II', 'Regional', 40, 'Positive', 'Positive', 19, 11, 1, 'Alive'),
(47, 'Other (American Indian/AK Native, Asian/Pacific Islander)', 'Married (including common law)', NULL, 'T2', 'N2', 'IIIA', 'Moderately differentiated; Grade II', 'Regional', 45, 'Positive', 'Positive', 25, 9, 2, 'Alive'),
(67, 'White', 'Married (including common law)', NULL, 'T2', 'N1', 'IIB', 'Poorly differentiated; Grade III', 'Regional', 25, 'Positive', 'Positive', 4, 1, 2, 'Dead'),
(46, 'White', 'Divorced', NULL, 'T1', 'N1', 'IIA', 'Moderately differentiated; Grade II', 'Regional', 19, 'Positive', 'Positive', 26, 1, 2, 'Dead'),
(63, 'White', 'Married (including common law)', NULL, 'T2', 'N2', 'IIIA', 'Moderately differentiated; Grade II', 'Regional', 35, 'Positive', 'Positive', 21, 5, 3, 'Dead'),
(49, 'White', 'Married (including common law)', NULL, 'T2', 'N3', 'IIIC', 'Moderately differentiated; Grade II', 'Regional', 32, 'Positive', 'Positive', 20, 11, 3, 'Alive'),
(64, 'White', 'Single (never married)', NULL, 'T2', 'N1', 'IIB', 'Moderately differentiated; Grade II', 'Regional', 22, 'Positive', 'Positive', 1, 1, 3, 'Dead'),
(55, 'White', 'Married (including common law)', NULL, 'T1', 'N1', 'IIA', 'Moderately differentiated; Grade II', 'Regional', 15, 'Positive', 'Positive', 9, 1, 3, 'Alive'),
(59, 'White', 'Single (never married)', NULL, 'T3', 'N1', 'IIIA', 'Moderately differentiated; Grade II', 'Regional', 70, 'Positive', 'Positive', 9, 1, 4, 'Dead');
