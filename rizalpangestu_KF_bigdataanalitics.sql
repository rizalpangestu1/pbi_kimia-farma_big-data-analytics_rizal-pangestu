# Rizal Pangestu
# Final Task Kimia Farma Big Data Analytics

CREATE TABLE rakamin_kf_analytics.tabel_analisis AS
SELECT
    ft.transaction_id AS transaction_id,
    ft.date AS date,
    ft.branch_id AS branch_id,
    kc.branch_name AS branch_name,
    kc.kota AS kota,
    kc.provinsi AS provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name AS customer_name,
    ft.product_id AS product_id,
    p.product_name AS product_name,
    ft.price AS actual_price,
    ft.discount_percentage AS discount_percentage,
    CASE
        WHEN ft.price <= 50000 THEN 0.10
        WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
        WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
        WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,
    ft.price - (ft.price * ft.discount_percentage) AS nett_sales,
    (ft.price - (ft.price * ft.discount_percentage)) * 
    CASE
        WHEN ft.price <= 50000 THEN 0.10
        WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
        WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
        WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS nett_profit,
    ft.rating AS rating_transaksi
FROM
    rakamin_kf_analytics.kf_final_transaction ft
JOIN
    rakamin_kf_analytics.kf_kantor_cabang kc ON ft.branch_id = kc.branch_id
JOIN
    rakamin_kf_analytics.kf_product p ON ft.product_id = p.product_id;
