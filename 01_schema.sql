-- ============================================================
--  E-Commerce Sales Analysis — Database Schema
--  Compatible with: SQL Server, MySQL, PostgreSQL (minor tweaks)
-- ============================================================

CREATE TABLE IF NOT EXISTS orders (
    Order_ID        VARCHAR(15)    PRIMARY KEY,
    Order_Date      DATE           NOT NULL,
    Ship_Date       DATE           NOT NULL,
    Customer_ID     VARCHAR(10)    NOT NULL,
    Category        VARCHAR(30)    NOT NULL,
    Product         VARCHAR(50)    NOT NULL,
    Region          VARCHAR(15)    NOT NULL,
    Quantity        INT            NOT NULL,
    Unit_Price      DECIMAL(10,2)  NOT NULL,
    Discount        DECIMAL(5,2)   NOT NULL DEFAULT 0,
    Revenue         DECIMAL(12,2)  NOT NULL,
    Cost            DECIMAL(12,2)  NOT NULL,
    Profit          DECIMAL(12,2)  NOT NULL,
    Profit_Margin   DECIMAL(6,2)   NOT NULL,
    Shipping_Method VARCHAR(15)    NOT NULL,
    Order_Status    VARCHAR(15)    NOT NULL
);

-- Indexes for performance
CREATE INDEX idx_order_date    ON orders(Order_Date);
CREATE INDEX idx_category      ON orders(Category);
CREATE INDEX idx_region        ON orders(Region);
CREATE INDEX idx_order_status  ON orders(Order_Status);
CREATE INDEX idx_customer      ON orders(Customer_ID);
