-- Membuat database
CREATE DATABASE musetix;
USE musetix;

-- Tabel users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    username VARCHAR(255),
    biografi TEXT,
    link_facebook VARCHAR(255),
    link_discord VARCHAR(255),
    favorit_count INT DEFAULT 0,
    profile_picture VARCHAR(255)
);

-- Tabel categories
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) UNIQUE
);

-- Tabel events
CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT, -- Menghubungkan kategori dengan events
    judul VARCHAR(255),
    deskripsi TEXT,
    tanggal DATE,
    jam_mulai TIME,
    jam_selesai TIME,
    komunitas VARCHAR(255),
    jumlah_tiket INT,
    tanggal_jual_mulai DATE,
    tanggal_jual_akhir DATE,
    tempat_duduk VARCHAR(255),
    harga DECIMAL(10, 2),
    gambar VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Tabel tickets
CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    event_id INT,
    status ENUM('Belum Dipakai', 'Sudah Dipakai'),
    barcode VARCHAR(255) UNIQUE,
    tanggal_pembelian DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (event_id) REFERENCES events(id)
);

-- Tabel favorit
CREATE TABLE favorit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    event_id INT,
    tanggal_favorit DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (event_id) REFERENCES events(id)
);

-- Tabel notifications
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    judul VARCHAR(255),
    isi TEXT,
    status ENUM('Belum Dibaca', 'Sudah Dibaca'),
    tanggal DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Tabel settings
CREATE TABLE settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    nama VARCHAR(255),
    username VARCHAR(255),
    link_facebook VARCHAR(255),
    link_discord VARCHAR(255),
    biografi TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Tabel user_events
CREATE TABLE user_events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    gambar VARCHAR(255),
    judul VARCHAR(255),
    deskripsi TEXT,
    tanggal DATE,
    jam_mulai TIME,
    jam_selesai TIME,
    komunitas VARCHAR(255),
    jumlah_tiket INT,
    tanggal_jual_mulai DATE,
    tanggal_jual_akhir DATE,
    tempat_duduk VARCHAR(255),
    harga DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Tabel payments
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    ticket_id INT,
    method ENUM('Debit', 'Virtual Account', 'QRIS'),
    status ENUM('Pending', 'Sukses', 'Gagal'),
    total_harga DECIMAL(10, 2),
    tanggal_pembayaran DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (ticket_id) REFERENCES tickets(id)
);

-- Tabel payment_details
CREATE TABLE payment_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT,
    method ENUM('Debit', 'Virtual Account', 'QRIS'),
    nomor_kartu VARCHAR(16),
    nama_pemilik VARCHAR(255),
    tanggal_expired DATE,
    cvv INT,
    bank VARCHAR(255),
    nomor_virtual_account VARCHAR(255),
    qr_code VARCHAR(255),
    status_scan ENUM('Belum Discan', 'Sudah Discan'),
    FOREIGN KEY (payment_id) REFERENCES payments(id)
);

-- Mengisi data default untuk tabel categories
INSERT INTO categories (nama) VALUES 
('Konser'),
('Orkestra'),
('Teater');
