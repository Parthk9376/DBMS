Student Academic Record Management System

Files:
- student_academic_record.sql: MySQL schema.
- Student_Academic_Record_Management_System.ipynb: Google Colab notebook (connection, tables, demo data, CRUD, SQL reports, graphs, viva).

Run:
1. Create a MySQL server/database.
2. Run the SQL file. For hosted MySQL, select the provider's database and omit CREATE DATABASE/USE if your account cannot create databases.
3. Open the notebook in Google Colab.
4. Add MYSQL_HOST, MYSQL_PORT, MYSQL_USER, MYSQL_PASSWORD and MYSQL_DATABASE in Colab Secrets.
5. If required by your provider, upload its CA certificate in the TLS cell.
6. Run all cells top-to-bottom.

Uses fictional demo data. Do not publish credentials. For remote connections, use TLS and restrict network access.
