# 🏠 Ứng dụng Quản Lý Phòng Trọ

> Đồ án Flutter - Quản lý phòng trọ đa cơ sở, đa phòng - Hướng chuyên sâu theo Clean Architecture

## 📱 Giới thiệu
Ứng dụng hỗ trợ người dùng quản lý phòng trọ, hợp đồng thuê, hóa đơn, và thống kê doanh thu theo cơ sở. Giao diện hiện đại, dễ sử dụng, hỗ trợ quản lý hiệu quả cho chủ trọ.

## 🚀 Tính năng chính
- Đăng nhập / Đăng ký
- Quản lý cơ sở trọ và phòng
- Quản lý hợp đồng thuê
- Quản lý hóa đơn điện nước
- Thống kê doanh thu
- Gửi thông báo cho người thuê
- Responsive UI hỗ trợ Mobile và Tablet

## 📂 Cấu trúc dự án
```
lib/
├── core/               # Base classes, constants, themes
├── data/               # Remote/local data sources, models
├── domain/             # Entities, use cases, repositories
├── presentation/       
│   ├── screens/        # UI screen theo module
│   ├── widgets/        # Custom widgets dùng chung
├── routes/             # Quản lý route toàn app
├── utils/              # Helpers, extensions
```

## 🛠 Công nghệ sử dụng
- Flutter 3.x
- Dart
- Provider / Riverpod / Bloc (tùy nhóm chọn)
- Firebase / SQLite
- GitHub Projects

## 🔧 Cách chạy dự án
```bash
git clone https://github.com/your-team/flutter-quan-ly-tro.git
cd flutter-quan-ly-tro
flutter pub get
flutter run
```

## 👨‍💻 Thành viên nhóm
| Họ tên         | MSSV     | Vai trò                  |
|----------------|----------|---------------------------|
| Nguyễn Văn A   | 12345678 | Trưởng nhóm - Backend logic |
| Trần Thị B     | 23456789 | Giao diện & điều hướng UI |
| Lê Văn C       | 34567890 | Tích hợp Firebase & Database |
| Phạm Thị D     | 45678901 | Thống kê & báo cáo       |

## 🗂 Quản lý công việc nhóm
- Quản lý task tại tab [Projects](https://github.com/your-repo/projects)
- Review code qua Pull Request
- Giao tiếp qua Discord/Slack

## 📸 Screenshot giao diện
*(Chèn ảnh màn hình app khi hoàn thiện)*

## 📃 Giấy phép
MIT License
