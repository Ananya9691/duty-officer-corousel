SELECT user FROM dual;
DROP TABLE duty_schedule CASCADE CONSTRAINTS;
DROP TABLE officer_master CASCADE CONSTRAINTS;
CREATE TABLE officer_master (
    personal_number NUMBER PRIMARY KEY,
    officer_name    VARCHAR2(100),
    image_path      VARCHAR2(200)
);

CREATE TABLE duty_schedule (
    duty_id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    duty_date       DATE,
    duty_day        VARCHAR2(10),
    duty_point      VARCHAR2(20),
    shift           VARCHAR2(10),
    standby_flag    CHAR(1),
    personal_number NUMBER,
    CONSTRAINT fk_officer
        FOREIGN KEY (personal_number)
        REFERENCES officer_master(personal_number)
);
INSERT INTO officer_master VALUES (1001, 'Rahul Sharma',  'rahul.jpg');
INSERT INTO officer_master VALUES (1002, 'Aman Verma',    'aman.jpg');
INSERT INTO officer_master VALUES (1003, 'Pooja Mehta',   'pooja.jpg');
INSERT INTO officer_master VALUES (1004, 'Ritesh Kumar',  'ritesh.jpg');
INSERT INTO officer_master VALUES (1005, 'Neha Singh',    'neha.jpg');
INSERT INTO officer_master VALUES (1006, 'Vikas Patel',   'vikas.jpg');
INSERT INTO officer_master VALUES (1007, 'Anjali Rao',    'anjali.jpg');
INSERT INTO officer_master VALUES (1008, 'Suresh Nair',   'suresh.jpg');
INSERT INTO officer_master VALUES (1009, 'Karan Malhotra','karan.jpg');
INSERT INTO officer_master VALUES (1010, 'Sneha Iyer',    'sneha.jpg');

COMMIT;
SELECT * FROM officer_master;



-- ACTIVE DUTY
INSERT INTO duty_schedule 
(duty_date, duty_day, duty_point, shift, standby_flag, personal_number)
VALUES (DATE '2025-12-30', 'MONDAY', 'MAIN_GATE', 'DAY', 'N', 1001);

INSERT INTO duty_schedule VALUES
(DEFAULT, DATE '2025-12-30', 'MONDAY', 'MAIN_GATE', 'NIGHT', 'N', 1002);

INSERT INTO duty_schedule VALUES
(DEFAULT, DATE '2025-12-30', 'MONDAY', 'HQ_GATE', 'DAY', 'N', 1003);

INSERT INTO duty_schedule VALUES
(DEFAULT, DATE '2025-12-30', 'MONDAY', 'HQ_GATE', 'NIGHT', 'N', 1004);

-- STANDBY DUTY
INSERT INTO duty_schedule VALUES
(DEFAULT, DATE '2025-12-30', 'MONDAY', 'MAIN_GATE', 'DAY', 'Y', 1005);

INSERT INTO duty_schedule VALUES
(DEFAULT, DATE '2025-12-30', 'MONDAY', 'MAIN_GATE', 'NIGHT', 'Y', 1006);

INSERT INTO duty_schedule VALUES
(DEFAULT, DATE '2025-12-30', 'MONDAY', 'HQ_GATE', 'DAY', 'Y', 1007);

INSERT INTO duty_schedule VALUES
(DEFAULT, DATE '2025-12-30', 'MONDAY', 'HQ_GATE', 'NIGHT', 'Y', 1008);

COMMIT;
SELECT duty_day, duty_point, shift, standby_flag, personal_number
FROM duty_schedule
ORDER BY standby_flag, duty_point, shift;
ALTER TABLE officer_master
ADD gender CHAR(1);
UPDATE officer_master SET gender = 'M' WHERE officer_name IN ('Rahul Sharma','Aman Verma','Ritesh Kumar','Suresh Nair','Vikas Patel','Karan Malhotra');
UPDATE officer_master SET gender = 'F' WHERE officer_name IN ('Pooja Mehta','Anjali Rao','Neha Singh','Sneha Iyer');

COMMIT;
DESC officer_master;
SELECT officer_name, gender FROM officer_master;


