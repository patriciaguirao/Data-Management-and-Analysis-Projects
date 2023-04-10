DROP TABLE IF EXISTS event_reports;
CREATE TABLE event_reports (
  report_id varchar(255) PRIMARY KEY,
  created_date date,
  event_date date
)  ;

DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
  patient_id varchar(255) PRIMARY KEY,
  patient_age integer,
  age_units varchar(255)
  sex varchar(255)
)  ;

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  product_name_id varchar(255) PRIMARY KEY,
  product_name text,
  product_type text
)  ;

DROP TABLE IF EXISTS product_codes;
CREATE TABLE products_codes (
  product_code_name_id varchar(255) PRIMARY KEY,
  description text,
  product_code text
)  ;

DROP TABLE IF EXISTS terms;
CREATE TABLE terms (
  terms_id varchar(255) PRIMARY KEY,
  terms text
)  ;

DROP TABLE IF EXISTS outcomes;
CREATE TABLE outcomes (
  outcomes_id varchar(255) PRIMARY KEY,
  outcomes text
)  ;

DROP TABLE IF EXISTS event_reports_patients;
CREATE TABLE event_reports_patients (
  CONSTRAINT event_reports_patients_ibfk_1 FOREIGN KEY (report_id) REFERENCES event_reports (report_id),
  CONSTRAINT event_reports_patients_ibfk_1 FOREIGN KEY (patient_id) REFERENCES patients (patinet_id)
)  ;

DROP TABLE IF EXISTS event_reports_products;
CREATE TABLE event_reports_products (
  CONSTRAINT event_reports_patients_ibfk_1 FOREIGN KEY (report_id) REFERENCES event_reports (report_id),
  CONSTRAINT event_reports_patients_ibfk_1 FOREIGN KEY (product_name_id) REFERENCES products (product_name_id)
)  ;

DROP TABLE IF EXISTS products_names_codes;
CREATE TABLE products_names_codes (
  CONSTRAINT event_reports_patients_ibfk_1 FOREIGN KEY (product_code_id) REFERENCES producst_code (product_code_id),
  CONSTRAINT event_reports_patients_ibfk_1 FOREIGN KEY (product_name_id) REFERENCES products (product_name_id)
)  ;

DROP TABLE IF EXISTS report_terms;
CREATE TABLE report_terms (
  CONSTRAINT event_reports_patients_ibfk_1 FOREIGN KEY (report_id) REFERENCES event_reports (report_id),
  CONSTRAINT event_reports_patients_ibfk_1 FOREIGN KEY (terms_id) REFERENCES terms (terms_id)
)  ;

DROP TABLE IF EXISTS report_outcomes;
CREATE TABLE report_outcomes (
  CONSTRAINT event_reports_patients_ibfk_1 FOREIGN KEY (report_id) REFERENCES event_reports (report_id),
  CONSTRAINT event_reports_patients_ibfk_1 FOREIGN KEY (outcomes_id) REFERENCES outcomes (outcomes_id)
)  ;
