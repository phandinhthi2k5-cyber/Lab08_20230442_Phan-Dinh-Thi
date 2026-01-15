-- Q1: Danh sách sách
SELECT b.book_id, b.title, c.name AS category_name, p.name AS publisher_name, b.price, b.stock
FROM books b
JOIN categories c ON b.category_id = c.category_id
JOIN publishers p ON b.publisher_id = p.publisher_id;

-- Q2: Thống kê số sách theo danh mục
SELECT c.name, COUNT(b.book_id) AS total_books
FROM categories c
LEFT JOIN books b ON c.category_id = b.category_id
GROUP BY c.category_id;

-- Q3: Danh sách phiếu mượn
SELECT l.loan_id, m.full_name, l.loan_date, l.due_date, l.status
FROM loans l
JOIN members m ON l.member_id = m.member_id;

-- Q4: Sách đang được mượn
SELECT m.full_name, b.title, li.qty, l.due_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN loan_items li ON l.loan_id = li.loan_id
JOIN books b ON li.book_id = b.book_id
WHERE l.status = 'BORROWED';

-- Q5: Top 5 sách mượn nhiều nhất
SELECT b.title, SUM(li.qty) AS total_qty
FROM loan_items li
JOIN books b ON li.book_id = b.book_id
GROUP BY b.book_id
ORDER BY total_qty DESC
LIMIT 5;

-- Q6: Số lần mượn theo thành viên
SELECT m.full_name, COUNT(DISTINCT l.loan_id) AS total_loans
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
GROUP BY m.member_id;

-- Q7: Sách chưa từng được mượn
SELECT b.book_id, b.title
FROM books b
LEFT JOIN loan_items li ON b.book_id = li.book_id
WHERE li.book_id IS NULL;

-- Q8: Phiếu mượn quá hạn
SELECT l.loan_id, m.full_name, l.due_date,
       DATEDIFF(CURDATE(), l.due_date) AS overdue_days
FROM loans l
JOIN members m ON l.member_id = m.member_id
WHERE l.status = 'BORROWED'
  AND l.due_date < CURDATE();

-- Q9: Tổng số sách mượn theo danh mục (qty >= 5)
SELECT c.name, SUM(li.qty) AS total_qty
FROM loan_items li
JOIN books b ON li.book_id = b.book_id
JOIN categories c ON b.category_id = c.category_id
GROUP BY c.category_id
HAVING total_qty >= 5;

-- Q10: Bạn đọc tích cực (>=3 phiếu trong 30 ngày)
SELECT m.full_name, COUNT(l.loan_id) AS total_loans
FROM members m
JOIN loans l ON m.member_id = l.member_id
WHERE l.loan_date >= CURDATE() - INTERVAL 30 DAY
GROUP BY m.member_id
HAVING total_loans >= 3;
