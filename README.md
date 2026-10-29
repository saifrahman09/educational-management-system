# Educational Management System (EMS)

## Overview

The Educational Management System is a small school administration project built with procedural PHP, PDO, MySQL/MariaDB, HTML5, Tailwind CSS, and JavaScript. An administrator can manage student and class records, publish notices, edit basic site information, and view admission reports.

The pages are server-rendered PHP files. Database queries and form handling are kept close to the pages that use them so the project remains straightforward to study and present.

## Features

- Admin sign-in and PHP session checks on the admin pages.
- Student record creation, viewing, editing, search, and deletion.
- Student image upload to the project `images/` folder, with a fallback image when no uploaded file is found.
- Class creation, listing, editing, and deletion.
- Class-specific notices linked to a class record.
- Public announcements and notices.
- Admission reports filtered by a date range. Date strings are validated and bound to PDO queries.
- Pagination page values are converted to integers and clamped to at least page 1.
- Most CRUD queries use PDO prepared statements with bound values.

This is a college project/prototype, not a production-ready school information system. In particular, account passwords still use legacy MD5, some delete actions use GET requests, and CSRF tokens and role-based permissions are not implemented. See [VIVA_PREP.md](./VIVA_PREP.md) for a concise discussion of these trade-offs.

## Requirements

- XAMPP or WAMP with Apache, PHP, and MySQL/MariaDB.
- PHP with the PDO MySQL extension enabled.
- A modern browser.
- Internet access for the CDN-hosted Tailwind and some icon/animation libraries used by the pages.

## Local setup (XAMPP / WAMP)

1. Start Apache and MySQL from the XAMPP/WAMP control panel.
2. Copy the project folder into the web root:
   - XAMPP: `C:\xampp\htdocs\education\`
   - WAMP: the corresponding `www\education\` folder.
3. Open phpMyAdmin, create a database named `education`, or import the SQL file directly. Import `database.sql` into the local MySQL/MariaDB server.
4. **Warning:** `database.sql` drops and recreates the six project tables. Importing it deletes existing rows in those tables. Back up any data you need before importing.
5. Check the credentials in [`includes/dbconnection.php`](./includes/dbconnection.php). The current local defaults are host `localhost`, database `education`, user `root`, and an empty password. Change these values if your local MySQL account uses different credentials.
6. Confirm the `images/` folder exists and is writable by Apache if you plan to upload student photos.
7. Browse to `http://localhost/education/`.

### Default administrator account

- Username: `admin`
- Password: `password123`

These are demo credentials included for local viva/testing. Change them immediately if this project is deployed anywhere accessible to others. The current application uses an MD5 password comparison, so the seeded digest exists for compatibility with the current login code; MD5 should not be used for a real deployment.

## Database notes

`database.sql` creates the six tables used by the PHP pages: `tbladmin`, `tblclass`, `tblstudent`, `tblnotice`, `tblpublicnotice`, and `tblpage`. It includes a small sample dataset for local testing.

Student class assignments and class notices are joined in application queries:

- `tblstudent.StudentClass` contains the corresponding `tblclass.ID` value as text, preserving the existing `tblstudent.sql` column type.
- `tblnotice.ClassId` contains a `tblclass.ID` value.

The student class field is kept as `varchar(100)` to match the supplied legacy dump, so it is an application-level relationship rather than a database foreign key.

## Main project files

- `index.php`, `logout.php` — admin sign-in and sign-out.
- `dashboard.php` — dashboard totals and recent notices.
- `add-students.php`, `manage-students.php`, `edit-student-detail.php`, `search.php` — student record workflows.
- `add-class.php`, `manage-class.php`, `edit-class-detail.php` — class workflows.
- `add-notice.php`, `manage-notice.php`, `edit-notice-detail.php` — class notices.
- `add-public-notice.php`, `manage-public-notice.php`, `edit-public-notice-detail.php` — public notices.
- `between-dates-reports.php`, `between-date-reprtsdetails.php` — admission date reports.
- `includes/` — database connection and shared page layout.
- `assets/` — stylesheets, scripts, images, and bundled frontend libraries.
- `database.sql` — complete local database setup and demo data.

