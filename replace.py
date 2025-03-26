import os

def replace_char_in_filenames(directory, target_char):
    for root, dirs, files in os.walk(directory):
        for filename in files:
            # Xây dựng đường dẫn đầy đủ
            old_file_path = os.path.join(root, filename)
            
            # Thay thế ký tự trong tên file
            new_filename = filename.replace(target_char, '')
            new_file_path = os.path.join(root, new_filename)
            
            # Đổi tên file nếu có thay đổi
            if old_file_path != new_file_path:
                os.rename(old_file_path, new_file_path)
                print(f"Đã đổi tên: {old_file_path} -> {new_file_path}")

# Ví dụ: thay thế ký tự '-' thành chuỗi rỗng trong các file của thư mục 'folder_path'
folder_path = r'D:\Vietnamese-Font'
replace_char_in_filenames(folder_path, "&")
