// Cấu hình Tailwind dùng chung: giữ nguyên hệ màu đỏ của hệ thống, đổi phông sang Poppins.
tailwind.config = {
    theme: {
        extend: {
            fontFamily: { sans: ['Poppins', 'ui-sans-serif', 'system-ui'] },
            colors: {
                brand: { 50: '#fef2f2', 100: '#fee2e2', 200: '#fecaca', 300: '#fca5a5', 500: '#ef4444', 600: '#dc2626', 700: '#b91c1c', 800: '#991b1b' }
            }
        }
    }
};
