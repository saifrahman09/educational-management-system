# Viva Voce Quick Reference

## 1. Architecture

**Short answer:** “The project uses procedural PHP with PDO and server-side rendering. Each PHP page handles its form input and relevant database queries, then renders the HTML. Shared database and layout code is included from the `includes` folder.”

**If asked for more detail:**

- `includes/dbconnection.php` creates a shared PDO connection called `$dbh`.
- Pages use PHP sessions for the administrator sign-in state.
- HTML forms send data with GET or POST; PHP reads those values and builds the response.
- Tailwind CSS and JavaScript are used for styling and browser interactions. Some older Bootstrap and vendor assets are also included.
- There is no MVC framework, separate API, or frontend single-page application.

## 2. Security and validation

**Short answer:** “Most create, update, and delete queries use PDO prepared statements. The date report validates the `YYYY-MM-DD` dates and binds them to the SQL query. Pagination values are cast to integers and values below one are reset to page one. Admin pages check the `sturecmsaid` session value.”

**Be accurate about the limits:**

- These checks are useful protections, but the project is still a learning prototype.
- Passwords use MD5 in the current login and password workflows. A production system should use PHP `password_hash()` and `password_verify()`.
- Some delete actions are still triggered by GET links. A stronger implementation would use POST requests and CSRF tokens.
- There is no role-based permission system or login rate limiting.
- Session checks confirm that an admin session exists; they are not a complete security model.
- Pagination casting prevents strings from being inserted into the numeric offset, and clamping prevents zero or negative pages. It does not replace proper validation for every possible query input.

## 3. Database relationships

**Short answer:** “Students and class notices are connected to classes through IDs. The pages join `tblstudent.StudentClass` or `tblnotice.ClassId` to `tblclass.ID` to show the class name and section.”

**Details:**

- `tblclass.ID` is the primary key for a class.
- `tblstudent.StudentClass` stores the class ID as a string because that is the type in the supplied legacy student schema. The PHP joins the value to `tblclass.ID`; there is no foreign key constraint for this column.
- `tblnotice.ClassId` stores the class ID used in the class-notice join.
- `tblpublicnotice` contains announcements not assigned to a class.
- `tblpage` stores the editable About Us and Contact Us content, distinguished by `PageType`.
- `tbladmin` stores administrator login and profile details.

The main integrity trade-off is that the student class column is text, rather than a numeric foreign-key column. The schema preserves it for compatibility with the original project.

## 4. Technical choices and trade-offs

### Why PDO?

PDO provides a consistent way to connect to MySQL and supports prepared statements with named parameters. It is already used throughout the codebase, so the project continues with PDO instead of introducing a second database API.

### Why server-side PHP?

For a small school management project, server-rendered pages keep the setup and request flow easy to understand. Each form submits to a PHP page, which validates or processes the input, accesses the database, and returns HTML.

### What should be improved before real deployment?

1. Replace MD5 password storage with `password_hash()` / `password_verify()` and reset the demo credentials.
2. Change GET-based delete operations to POST and add CSRF tokens.
3. Add stronger session cookie settings, regenerate the session ID after login, and add login throttling.
4. Add database constraints and change `StudentClass` to an integer foreign key in a planned migration.
5. Use a dedicated least-privilege database account instead of the default local `root` account.
6. Validate uploaded file content and size, and store uploads safely.

The schema script is intended for local project setup and includes a default account. It also drops and recreates the project tables, so it must not be imported over data that needs to be kept.

## 5. Useful demo flow

1. Sign in at `index.php` using the local demo administrator account.
2. Add or view classes, then add a student assigned to one of those classes.
3. View the student list, edit a record, and try the student search.
4. Add a class notice and a public notice.
5. Open the date report, submit a valid date range, and explain how the report query uses bound dates.
6. Sign out and confirm that protected pages return to the sign-in flow without the admin session.
