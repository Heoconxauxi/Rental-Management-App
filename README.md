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
├── core/                             # Các thành phần dùng chung toàn bộ ứng dụng
│   ├── errors/                       # Xử lý lỗi (Exception, Failure)
│   ├── usecases/                     # UseCase cơ bản dùng chung (e.g. NoParams, UseCase base class)
│   └── utils/                        # Tiện ích, helpers, constants, extensions dùng toàn cục
│
├── features/                         # Tổ chức theo tính năng (Feature-based modules)
│   ├── room/                         # Quản lý phòng trọ
│   │   ├── data/                     # Tầng Data: xử lý dữ liệu thô
│   │   │   ├── datasources/          # Nguồn dữ liệu (local: SQLite/shared_pref, remote: API)
│   │   │   ├── models/               # Data Transfer Object (DTO) từ datasource
│   │   │   └── repositories/         # Cài đặt cụ thể repository (implements domain repo)
│   │   ├── domain/                   # Tầng Domain: business logic thuần
│   │   │   ├── entities/             # Định nghĩa Room entity (model không phụ thuộc tầng khác)
│   │   │   ├── repositories/         # Giao diện repository trừu tượng (abstract class)
│   │   │   └── usecases/             # Các hành động nghiệp vụ cụ thể (GetRooms, AddRoom,...)
│   │   └── presentation/             # Tầng UI & State Management
│   │       ├── pages/                # Các màn hình UI (RoomListPage, RoomDetailPage,...)
│   │       ├── providers/            # StateNotifier, Provider quản lý state theo Riverpod
│   │       ├── states/               # Các class trạng thái (RoomState: loading, loaded, error,...)
│   │       └── widgets/              # Các UI component dùng lại (RoomItemTile, RoomForm,...)
│   ├── home/                         # Màn hình Home / Dashboard (có thể gom navigation chính)
│   ├── account/                      # Màn hình đăng kí / đăng nhập / quản lí người dùng, phân quyền
│   ├── tenant/                       # Tính năng quản lý người thuê (cấu trúc tương tự room/)
│   ├── contract/                     # Tính năng hợp đồng thuê nhà
│   ├── bill/                         # Quản lý hóa đơn điện, nước,...
│   └── branch/                       # Quản lý cơ sở/phân khu/phòng trọ theo chi nhánh
│
├── injection/                        # Thiết lập Dependency Injection
│   └── service_locator.dart          # Đăng ký các dependency bằng get_it hoặc injectable
│
└── main.dart                         # Entry point khởi chạy ứng dụng

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
