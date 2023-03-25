CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- 1. List the employee number, last name, first name, sex, and salary of each
-- employee.

select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
left join salaries on employees.emp_no = salaries.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired
-- in 1986.

select employees.first_name, employees.last_name, employees.hire_date
from employees
where hire_date between '1986-01-01' and '1986-12-31';

-- 3. List the manager of each department along with their department number,
-- department name, employee number, last name, and first name.

select departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
from departments
inner join dept_manager on departments.dept_no = dept_manager.dept_no
inner join employees on dept_manager.emp_no = employees.emp_no;

-- 4. List department number for each employee along with that employee's employee number, last name,
-- first name, and department name.

select dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from departments
inner join dept_emp on departments.dept_no = dept_emp.dept_no
inner join employees on dept_emp.emp_no = employees.emp_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name
-- begins with the letter B.

select employees.first_name, employees.last_name, employees.sex
from employees
where first_name = 'Hercules' and last_name like 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and 
-- first name.

select departments.dept_name, dept_emp.emp_no, employees.last_name, employees.first_name
from dept_emp
inner join employees on dept_emp.emp_no = employees.emp_no
inner join departments on dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number,
-- last name, first name, and department name.

select departments.dept_name, dept_emp.emp_no, employees.last_name, employees.first_name
from dept_emp
inner join employees on dept_emp.emp_no = employees.emp_no
inner join departments on dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales' or dept_name = 'Development';

-- 8. List the frequency counts, in descending order, of all the employee last names (that is,
-- how many employees share each last name.)

select last_name, count(last_name) as "frequency counts"
from employees
group by last_name
order by "frequency counts" desc;






