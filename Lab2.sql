CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(50) NOT NULL
);

CREATE TABLE subjects (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE topics (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  subject_id SERIAL NOT NULL REFERENCES subjects(id)
);

CREATE TABLE materials (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT,
  topic_id INTEGER NOT NULL REFERENCES topics(id)
);

CREATE TABLE tasks (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT,
  material_id INTEGER NOT NULL REFERENCES materials(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE results (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  task_id INTEGER NOT NULL REFERENCES tasks(id),
  mark INTEGER NOT NULL,
  completed_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE hub_customer (
    customer_id INT NOT NULL AUTO_INCREMENT,
    customer_code VARCHAR(50) NOT NULL,
    load_date TIMESTAMP NOT NULL DEFAULT NOW(),
    record_surce VARCHAR(50) NOT NULL,
    PRIMARY KEY (customer_id)
);

CREATE TABLE hub_product (
    product_id INT NOT NULL AUTO_INCREMENT,
    product_code VARCHAR(50) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(50) NOT NULL,
load_date TIMESTAMP NOT NULL DEFAULT NOW(),
record_surce VARCHAR(50) NOT NULL,
    PRIMARY KEY (product_id)
);

CREATE TABLE link_sales (
    sales_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    sales_date DATE NOT NULL,
load_date TIMESTAMP NOT NULL DEFAULT NOW(),
record_surce VARCHAR(50) NOT NULL,
    PRIMARY KEY (sales_id),
    FOREIGN KEY (customer_id) REFERENCES hub_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES hub_product(product_id)
);

CREATE TABLE sat_customer (
    customer_id INT NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE,
    is_current BOOLEAN NOT NULL DEFAULT TRUE,
    customer_address VARCHAR(200),
    customer_phone VARCHAR(20),
    customer_email VARCHAR(50),
load_date TIMESTAMP NOT NULL DEFAULT NOW(),
record_surce VARCHAR(50) NOT NULL,
    PRIMARY KEY (customer_id, valid_from),
    FOREIGN KEY (customer_id) REFERENCES hub_customer(customer_id)
);

CREATE TABLE sat_product (
    product_id INT NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE,
    is_current BOOLEAN NOT NULL DEFAULT TRUE,
    product_description TEXT,
    product_price NUMERIC(10,2),
load_date TIMESTAMP NOT NULL DEFAULT NOW(),
record_surce VARCHAR(50) NOT NULL,
    PRIMARY KEY (product_id, valid_from),
    FOREIGN KEY (product_id) REFERENCES hub_product(product_id)
);

CREATE TABLE dv_metadata (
    object_type VARCHAR(50) NOT NULL,
    object_name VARCHAR(100) NOT NULL,
    attribute_name VARCHAR(100),
    attribute_value TEXT,
    load_date TIMESTAMP NOT NULL DEFAULT NOW(),
record_surce VARCHAR(50) NOT NULL,
    PRIMARY KEY (object_type, object_name, attribute_name, load_date)
);

CREATE TABLE dv_audit (
    table_name VARCHAR(100) NOT NULL,
    operation_type VARCHAR(10) NOT NULL,
    operation_date TIMESTAMP NOT NULL DEFAULT NOW(),
    user_name VARCHAR(50),
load_date TIMESTAMP NOT NULL DEFAULT NOW(),
record_surce VARCHAR(50) NOT NULL,
    PRIMARY KEY (table_name, operation_type, operation_date)
);
