CREATE TABLE notice (
  notice_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(200) NOT NULL,
  content TEXT NOT NULL,
  is_published CHAR(1) NOT NULL DEFAULT 'N',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL
);

CREATE INDEX idx_notice_created_at ON notice (created_at);
CREATE INDEX idx_notice_title ON notice (title);
