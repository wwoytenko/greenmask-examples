CREATE TABLE account
(
    id         SERIAL PRIMARY KEY,
    gender     VARCHAR(1) NOT NULL,
    email      TEXT       NOT NULL NOT NULL UNIQUE,
    first_name TEXT       NOT NULL,
    last_name  TEXT       NOT NULL,
    birth_date DATE,
    created_at TIMESTAMP  NOT NULL DEFAULT NOW()
);

INSERT INTO account (first_name, gender, last_name, birth_date, email)
VALUES ('John', 'M', 'Smith', '1980-01-01', 'john.smith@gmail.com');

CREATE TABLE orders
(
    id          SERIAL PRIMARY KEY,
    account_id  INTEGER REFERENCES account (id),
    total_price NUMERIC(10, 2),
    created_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    paid_at     TIMESTAMP
);

INSERT INTO orders (account_id, total_price, created_at, paid_at)
VALUES (1, 100.50, '2024-05-01', '2024-05-02'),
       (1, 200.75, '2024-05-03', NULL);
