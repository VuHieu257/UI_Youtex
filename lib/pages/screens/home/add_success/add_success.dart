import 'package:flutter/material.dart';

class CardAddedSuccessDialog extends StatelessWidget {
  const CardAddedSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Kích thước vừa đủ nội dung
          children: [
            // Icon checkmark
            const Icon(
              Icons.check_circle,
              size: 60,
              color: Colors.green, // Màu xanh của biểu tượng
            ),
            const SizedBox(height: 20),
            // Tiêu đề "Congratulations!"
            const Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            // Nội dung thông báo
            const Text(
              'Your new card has been added.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            // Nút "Thanks"
            SizedBox(
              width: double.infinity, // Nút full chiều ngang của hộp
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng dialog khi bấm nút
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Màu nền của nút
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Thanks',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
